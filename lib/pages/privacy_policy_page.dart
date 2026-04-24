/// 隐私政策页面
///
/// 展示应用完整的隐私保护条款
library;

import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const _bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E3A5F), Color(0xFF3D5A80), Color(0xFF98C1D9)],
    stops: [0.0, 0.4, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _bg),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildSection('更新日期', '2026年4月24日'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('一、信息收集'),
                    _buildParagraph(
                      '我们非常重视您的隐私保护。本应用在提供服务过程中，仅会收集以下必要信息：',
                    ),
                    _buildBulletItem('您主动选择的视频/音频文件（仅用于本地处理，不会上传至任何服务器）'),
                    _buildBulletItem('设备基本信息（品牌、型号、制造商等，用于免费试用次数管理与设备适配，不包含个人身份信息）'),
                    _buildBulletItem('应用内购买记录（通过苹果App Store或Google Play完成，我们仅获知购买是否成功，不收集支付账户等敏感信息）'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('二、信息使用'),
                    _buildParagraph(
                      '所有音视频处理均在您的设备本地完成，我们不会将您的任何文件或数据上传至远程服务器。具体用途如下：',
                    ),
                    _buildBulletItem('设备基本信息：用于生成设备指纹，管理免费试用次数（7次），防止试用次数被篡改'),
                    _buildBulletItem('应用内购买记录：用于验证高级版购买状态，解锁全部功能'),
                    _buildBulletItem('使用次数数据：经AES-256加密后存储在设备本地，用于免费试用计数'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('三、信息存储与安全'),
                    _buildParagraph(
                      '我们采取以下措施保护您的数据安全：',
                    ),
                    _buildBulletItem('应用产生的临时文件存储在设备本地临时目录中，处理完成后可由您自行保存或删除'),
                    _buildBulletItem('免费试用次数及购买状态使用AES-256-CBC算法加密存储在设备本地，密钥由设备指纹派生'),
                    _buildBulletItem('加密数据附带HMAC-SHA256完整性校验，可检测任何篡改行为'),
                    _buildBulletItem('我们不会在服务器端存储您的任何数据'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('四、信息共享'),
                    _buildParagraph(
                      '我们不会将您的个人信息出售、交易或以其他方式转让给外部第三方。以下情况除外：',
                    ),
                    _buildBulletItem('获得您的明确同意后'),
                    _buildBulletItem('根据法律法规或政府要求'),
                    _buildBulletItem('应用内购买由苹果App Store或Google Play处理，受其各自的隐私政策约束'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('五、第三方服务'),
                    _buildParagraph(
                      '本应用使用了部分第三方SDK来提供服务，这些SDK可能会有其独立的隐私政策。详情请查看"第三方SDK列表"页面。主要第三方服务包括：',
                    ),
                    _buildBulletItem('FFmpeg：音视频处理核心引擎，完全在本地运行'),
                    _buildBulletItem('Google Play Billing / Apple StoreKit：用于处理应用内购买，受Google和Apple隐私政策约束'),
                    _buildBulletItem('device_info_plus：用于获取设备基本信息以生成设备指纹'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('六、权限说明'),
                    _buildParagraph(
                      '本应用需要以下系统权限才能正常工作：',
                    ),
                    _buildBulletItem('存储/相册权限：用于读取您选择的视频文件，以及将处理后的文件保存到相册'),
                    _buildBulletItem('麦克风权限：仅在配音功能中使用，用于录制音频'),
                    _buildBulletItem('网络权限：仅用于验证应用内购买状态，不用于上传任何用户数据'),
                    const SizedBox(height: 16),

                    _buildSectionTitle('七、数据安全'),
                    _buildParagraph(
                      '我们采取合理的安全措施保护您的信息不被未经授权的访问、使用或泄露。所有敏感数据均使用AES-256加密存储在设备本地，密钥与设备硬件绑定。但请注意，互联网环境并非绝对安全，我们建议您妥善保管设备。',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('八、未成年人保护'),
                    _buildParagraph(
                      '我们非常重视对未成年人个人信息的保护。若您是未满18周岁的未成年人，建议在监护人指导下使用本应用。我们不会 knowingly 收集未成年人的个人信息。',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('九、隐私政策变更'),
                    _buildParagraph(
                      '我们可能会适时修订本隐私政策。当政策发生变更时，我们会在应用内通过弹窗或公告的方式通知您。继续使用本应用即视为同意修订后的隐私政策。',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('十、联系我们'),
                    _buildParagraph(
                      '如您对本隐私政策有任何疑问或建议，请通过以下方式联系我们：\nxinyoushanhai888@gmail.com',
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              '隐私政策',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSection(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.85),
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
