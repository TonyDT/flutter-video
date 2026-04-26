// storage_service.dart
// 安全存储服务 - AES-256-CBC 加密 + 设备指纹绑定 + HMAC 完整性校验

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' hide Key;
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // 存储键
  static const String _keyIsPremium = 'is_premium_unlocked_v2';
  static const String _keyFreeCount = 'free_count_secure';
  static const String _keyFirstLaunchShown = 'first_launch_shown_v2';

  // 初始免费次数
  static const int initialFreeCount = 7;

  // AES 密钥派生盐值（不要修改，否则已加密数据将失效）
  static const String _keySalt = 'TkTl_k1t_s3cur3_s@lt_2024';

  // 缓存
  static String? _cachedFingerprint;
  static Key? _cachedKey;

  // ==================== 设备指纹 ====================

  /// 获取设备指纹（用于 AES 密钥派生）
  Future<String> _getDeviceFingerprint() async {
    if (_cachedFingerprint != null) return _cachedFingerprint!;

    final deviceInfo = DeviceInfoPlugin();
    String fingerprint;

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      // 使用不可变的硬件属性组合
      fingerprint = 'android:${info.brand}:${info.model}:${info.manufacturer}:${info.hardware}';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      fingerprint = 'ios:${info.name}:${info.model}:${info.systemName}:${info.utsname.machine}';
    } else {
      fingerprint = 'unknown_device';
    }

    _cachedFingerprint = fingerprint;
    return fingerprint;
  }

  /// 从设备指纹派生 AES-256 密钥（SHA-256 哈希 → 32 字节密钥）
  Future<Key> _deriveKey() async {
    if (_cachedKey != null) return _cachedKey!;

    final fingerprint = await _getDeviceFingerprint();
    final bytes = utf8.encode(fingerprint + _keySalt);
    final hash = sha256.convert(bytes);
    _cachedKey = Key(Uint8List.fromList(hash.bytes));
    return _cachedKey!;
  }

  // ==================== AES-256-CBC 加解密 ====================

  /// 加密明文，返回格式: ivBase64:hmacHex:cipherBase64
  Future<String> _encrypt(String plainText) async {
    final key = await _deriveKey();
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // HMAC 完整性校验（取前 32 字符作为校验码）
    final hmacValue = _computeHmac(key, iv.base64, encrypted.base64);

    return '${iv.base64}:$hmacValue:${encrypted.base64}';
  }

  /// 解密密文，格式: ivBase64:hmacHex:cipherBase64
  /// 返回 null 表示数据被篡改或损坏
  Future<String?> _decrypt(String payload) async {
    try {
      final parts = payload.split(':');
      if (parts.length != 3) return null;

      final key = await _deriveKey();
      final ivBase64 = parts[0];
      final storedHmac = parts[1];
      final cipherBase64 = parts[2];

      // 1. HMAC 完整性校验
      final computedHmac = _computeHmac(key, ivBase64, cipherBase64);
      if (computedHmac != storedHmac) return null; // 篡改检测

      // 2. 解密
      final iv = IV.fromBase64(ivBase64);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      return encrypter.decrypt64(cipherBase64, iv: iv);
    } catch (e) {
      debugPrint('StorageService decrypt error: $e');
      return null;
    }
  }

  /// 计算 HMAC-SHA256 校验码（取前 32 字符）
  String _computeHmac(Key key, String ivBase64, String cipherBase64) {
    final hmac = Hmac(sha256, key.bytes);
    final digest = hmac.convert(utf8.encode(ivBase64 + cipherBase64));
    return digest.toString().substring(0, 32);
  }

  // ==================== 免费次数管理 ====================

  /// 读取免费剩余次数（首次自动初始化）
  Future<int> getFreeCount() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(_keyFreeCount);

    // 首次使用，初始化
    if (payload == null) {
      await setFreeCount(initialFreeCount);
      return initialFreeCount;
    }

    // 解密
    final decrypted = await _decrypt(payload);
    if (decrypted == null) {
      // 解密失败（篡改或设备指纹变化），重置为初始值
      debugPrint('Free count decrypt failed, resetting to initial');
      await setFreeCount(initialFreeCount);
      return initialFreeCount;
    }

    final count = int.tryParse(decrypted);
    if (count == null || count < 0) {
      await setFreeCount(initialFreeCount);
      return initialFreeCount;
    }

    return count;
  }

  /// 设置免费剩余次数（AES-256 加密保存）
  Future<void> setFreeCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = await _encrypt(count.toString());
    await prefs.setString(_keyFreeCount, encrypted);
  }

  /// 扣减1次并持久化，返回剩余次数
  Future<int> decrementFreeCount() async {
    final current = await getFreeCount();
    final next = current > 0 ? current - 1 : 0;
    await setFreeCount(next);
    return next;
  }

  // ==================== 购买状态管理 ====================

  /// 存储是否已购买高级版
  Future<void> setPremiumUnlocked(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    // 购买状态也加密存储
    final encrypted = await _encrypt(value ? '1' : '0');
    await prefs.setString(_keyIsPremium, encrypted);
  }

  /// 获取是否已购买高级版
  Future<bool> isPremiumUnlocked() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(_keyIsPremium);
    if (payload == null) return false;

    final decrypted = await _decrypt(payload);
    if (decrypted == null) return false;

    return decrypted == '1';
  }

  // ==================== 首次启动标记 ====================

  /// 是否已显示过首次启动欢迎弹窗
  Future<bool> isFirstLaunchShown() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(_keyFirstLaunchShown);
    if (payload == null) return false;

    final decrypted = await _decrypt(payload);
    return decrypted == '1';
  }

  /// 标记首次启动欢迎弹窗已显示
  Future<void> setFirstLaunchShown() async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = await _encrypt('1');
    await prefs.setString(_keyFirstLaunchShown, encrypted);
  }
}
