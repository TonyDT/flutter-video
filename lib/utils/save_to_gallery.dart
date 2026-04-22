/// 相册保存统一工具 - 所有保存操作走这里
library;

import 'package:flutter/material.dart';
import 'gallery_saver_helper.dart';

class SaveToGallery {
  /// 统一保存到相册方法
  ///
  /// [path] 文件路径
  /// [context] BuildContext（用于显示提示）
  /// 返回是否成功
  static Future<bool> save(String path, {required BuildContext context}) async {
    try {
      final result = await GallerySaverHelper.saveFile(path);
      if (result == true) {
        _showSuccess(context, '已保存到相册');
        return true;
      } else {
        _showError(context, '保存失败，请检查权限设置');
        return false;
      }
    } catch (e) {
      _showError(context, '保存异常: $e');
      return false;
    }
  }

  /// 批量保存多个文件
  static Future<int> saveAll(List<String> paths, {required BuildContext context}) async {
    int count = 0;
    for (final path in paths) {
      final ok = await save(path, context: context);
      if (ok) count++;
    }
    return count;
  }

  static void _showSuccess(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg), backgroundColor: Colors.green.shade700, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), duration: const Duration(seconds: 2),
  ));

  static void _showError(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg), backgroundColor: Colors.red.shade700, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), duration: const Duration(seconds: 3),
  ));
}
