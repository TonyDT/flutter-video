// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => '全部';

  @override
  String get tabSettings => '设置';

  @override
  String get settingsAbout => '设置与关于';

  @override
  String get appearance => '外观设置';

  @override
  String get lightMode => '浅色模式';

  @override
  String get darkMode => '深色模式';

  @override
  String get aboutApp => '关于应用';

  @override
  String get appNameLabel => '应用名称';

  @override
  String get versionLabel => '版本号';

  @override
  String get developerLabel => '开发者';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get viewPrivacyTerms => '查看隐私保护条款';

  @override
  String get sdkList => '第三方SDK列表';

  @override
  String get viewThirdPartyServices => '查看第三方服务';

  @override
  String get iapDescription => '内购说明';

  @override
  String get viewIapDetails => '查看内购项目与订阅详情';

  @override
  String get iapSection1Title => '一、内购项目';

  @override
  String get iapSection1Content =>
      '本应用提供「高级版」内购项目，为一次性购买，非自动续期订阅。购买后即可永久解锁全部功能，包括：无限次保存到相册、所有工具无限制使用、未来新功能免费更新、无广告干扰。';

  @override
  String get iapSection2Title => '二、付款与确认';

  @override
  String get iapSection2Content =>
      '购买将通过您的 Apple ID / Google Play 账户扣款。确认购买后，款项将从您的账户中扣除。';

  @override
  String get iapSection3Title => '三、恢复购买';

  @override
  String get iapSection3Content =>
      '若您更换设备或重新安装应用，可在设置页面或商店页面点击「恢复购买记录」，即可免费恢复已购买的高级版权限，无需重复付费。';

  @override
  String get iapSection4Title => '四、取消与退款';

  @override
  String get iapSection4Content =>
      '本内购为一次性购买，购买成功后不支持退款。如需退款，请通过 Apple / Google Play 官方渠道申请。';

  @override
  String get iapSection5Title => '五、联系我们';

  @override
  String get iapSection5Content =>
      '如您对内购有任何疑问，请联系：\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => '欢迎使用 ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return '您有 $count 次免费使用机会，每次保存到相册将消耗 1 次。';
  }

  @override
  String get welcomeUpgradeHint => '升级高级版可无限次使用所有功能';

  @override
  String get welcomeGotIt => '知道了';

  @override
  String get welcomeUpgrade => '升级高级版';

  @override
  String freeCountRemaining(int count) {
    return '剩余 $count 次';
  }

  @override
  String get freeCountExhausted => '免费次数已用完';

  @override
  String get upgradeToUnlock => '升级高级版解锁无限次使用';

  @override
  String get openSourceNotice => '基于 FFmpeg、Flutter 等开源技术构建，感谢开源社区贡献。';

  @override
  String get harmonyDeveloping => '鸿蒙版正在开发中';

  @override
  String get language => '语言';

  @override
  String get toolMerge => '合并视频';

  @override
  String get toolMergeDesc => '将多个视频文件合并成一个';

  @override
  String get toolCut => '视频截取';

  @override
  String get toolCutDesc => '从视频中截取指定时间段';

  @override
  String get toolCompress => '视频压缩';

  @override
  String get toolCompressDesc => '减小视频文件大小';

  @override
  String get toolRatio => '视频比例';

  @override
  String get toolRatioDesc => '调整画面宽高比';

  @override
  String get toolMute => '视频消音';

  @override
  String get toolMuteDesc => '去除视频中音频轨道';

  @override
  String get toolDubbing => '视频配音';

  @override
  String get toolDubbingDesc => '为视频添加背景音乐';

  @override
  String get toolExtract => '提取图片';

  @override
  String get toolExtractDesc => '从视频中提取帧图片';

  @override
  String get toolSplit => '视频分割';

  @override
  String get toolSplitDesc => '将视频分割成多段';

  @override
  String get toolSeparate => '音视频分离';

  @override
  String get toolSeparateDesc => '分离音视频轨道';

  @override
  String get toolCrop => '视频裁剪';

  @override
  String get toolCropDesc => '裁剪视频画面区域';

  @override
  String get toolConvert => '格式转换';

  @override
  String get toolConvertDesc => '转换视频文件格式';

  @override
  String toolCountAll(int count) {
    return '$count 款 · 全部';
  }

  @override
  String featureDeveloping(String name) {
    return '$name 功能开发中';
  }

  @override
  String get selectVideoFailed => '选择视频失败';

  @override
  String get selectAudioFailed => '选择音频失败';

  @override
  String get needAlbumPermission => '需要相册权限';

  @override
  String get savedToAlbum => '已保存到相册';

  @override
  String get saveFailed => '保存失败';

  @override
  String saveError(String error) {
    return '保存出错: $error';
  }

  @override
  String get loading => '加载中...';

  @override
  String get tapToSelectVideo => '点击选择视频';

  @override
  String get tapToSelectFirstVideo => '点击选择第一个视频';

  @override
  String get tapToSelectSecondVideo => '点击选择第二个视频';

  @override
  String get tapToPreview => '点击预览';

  @override
  String get start => '开始';

  @override
  String get end => '结束';

  @override
  String get change => '更换';

  @override
  String get reselect => '重新选择';

  @override
  String get changeVideo => '更换视频';

  @override
  String get saveToAlbum => '保存到相册';

  @override
  String get processing => '处理中...';

  @override
  String get videoLoadFailed => '视频加载失败';

  @override
  String get previewFailed => '预览失败';

  @override
  String get previewInitFailed => '预览初始化失败';

  @override
  String get mergeVideo => '合并视频';

  @override
  String get selectTwoVideosToMerge => '选择两个视频进行合并';

  @override
  String get video1 => '视频 1';

  @override
  String get video2 => '视频 2';

  @override
  String get selectVideo1 => '选择视频 1';

  @override
  String get selectVideo2 => '选择视频 2';

  @override
  String get pleaseSelectTwoVideos => '请先选择两个视频';

  @override
  String get webNotSupportMerge => 'Web 平台暂不支持合并';

  @override
  String get video1CropFailed => '视频1裁剪失败';

  @override
  String get video2CropFailed => '视频2裁剪失败';

  @override
  String get mergeSuccess => '合并成功！';

  @override
  String get mergeFailed => '合并失败';

  @override
  String mergeError(String error) {
    return '合并异常: $error';
  }

  @override
  String get merging => '合并中...';

  @override
  String get startMerge => '开始合并';

  @override
  String get compressVideo => '视频压缩';

  @override
  String get compressSuccess => '压缩完成！';

  @override
  String get compressFailed => '压缩失败';

  @override
  String compressError(String error) {
    return '压缩出错: $error';
  }

  @override
  String originalSize(String size) {
    return '原始大小: $size';
  }

  @override
  String compressQuality(int value) {
    return '压缩质量 (CRF): $value';
  }

  @override
  String get compressTip => '提示: 数值越大压缩越多，画质越低';

  @override
  String get encodeSpeed => '编码速度:';

  @override
  String compressedSize(String size) {
    return '压缩后: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return '节省: $size ($percent%)';
  }

  @override
  String get compressing => '压缩中...';

  @override
  String get startCompress => '开始压缩';

  @override
  String get convertFormat => '格式转换';

  @override
  String get convertSuccess => '转换成功！';

  @override
  String get convertFailed => '转换失败';

  @override
  String convertError(String error) {
    return '转换出错: $error';
  }

  @override
  String get targetFormat => '目标格式:';

  @override
  String get converting => '转换中...';

  @override
  String convertTo(String format) {
    return '转换为 $format';
  }

  @override
  String get cropVideo => '视频裁剪';

  @override
  String get cropSuccess => '裁剪成功！';

  @override
  String get cropFailed => '裁剪失败';

  @override
  String cropError(String error) {
    return '裁剪出错: $error';
  }

  @override
  String get cropPreviewFailedButSaved => '预览裁剪结果失败，但文件已生成';

  @override
  String originalResolution(int width, int height) {
    return '原始: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return '裁剪: ${width}x$height';
  }

  @override
  String get cropDragTip => '拖动绿色方块或边线调整裁剪区域，拖动框内移动位置';

  @override
  String get resetCrop => '重置裁剪区域';

  @override
  String get cropping => '裁剪中...';

  @override
  String get startCrop => '开始裁剪';

  @override
  String get cutVideo => '视频截取';

  @override
  String get cutSuccess => '截取成功！';

  @override
  String get cutFailed => '截取失败';

  @override
  String cutError(String error) {
    return '截取出错: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => '截取完成（预览不可用）';

  @override
  String get videoPreviewUnavailable => '视频预览不可用';

  @override
  String totalDuration(String duration) {
    return '总时长: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return '截取: $start - $end  ($duration)';
  }

  @override
  String get cutting => '截取中...';

  @override
  String get startCut => '开始截取';

  @override
  String get dubbingVideo => '视频配音';

  @override
  String get dubbingSuccess => '配音成功！';

  @override
  String get dubbingFailed => '配音失败';

  @override
  String dubbingError(String error) {
    return '配音出错: $error';
  }

  @override
  String get selectVideo => '选择视频';

  @override
  String get videoSelected => '已选择视频';

  @override
  String get selectAudio => '选择音频';

  @override
  String get audioSelected => '已选择音频';

  @override
  String get dubbingMode => '配音模式:';

  @override
  String get replaceOriginalAudio => '替换原音频';

  @override
  String get replaceAudioHint => '关闭则混合两路音频';

  @override
  String get dubbing => '配音中...';

  @override
  String get startDubbing => '开始配音';

  @override
  String get startOver => '重新来过';

  @override
  String get extractImages => '提取图片';

  @override
  String get startTimeMustBeBeforeEnd => '开始时间必须小于结束时间';

  @override
  String extractedCount(int count) {
    return '提取了 $count 张图片';
  }

  @override
  String get noImagesExtracted => '未能提取到图片，请检查视频文件';

  @override
  String get extractFailed => '提取失败';

  @override
  String extractError(String error) {
    return '提取出错: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return '已保存 $count 张图片到相册';
  }

  @override
  String videoDuration(String duration) {
    return '视频时长: $duration';
  }

  @override
  String get startTime => '开始时间';

  @override
  String get endTime => '结束时间';

  @override
  String extractRange(String start, String end, String duration) {
    return '提取范围: $start - $end  (共 $duration)';
  }

  @override
  String extractFps(String fps) {
    return '提取频率: $fps 帧/秒';
  }

  @override
  String estimatedImages(int count) {
    return '预计提取约 $count 张图片';
  }

  @override
  String get extracting => '提取中...';

  @override
  String get startExtract => '开始提取';

  @override
  String extractedImagesCount(int count) {
    return '已提取 $count 张图片';
  }

  @override
  String showingFirst30(int count) {
    return '仅显示前30张，共 $count 张';
  }

  @override
  String saveAllCount(int count) {
    return '保存全部 $count 张';
  }

  @override
  String get muteVideo => '视频消音';

  @override
  String get muteSuccess => '消音成功！';

  @override
  String get muteFailed => '消音失败';

  @override
  String muteError(String error) {
    return '消音出错: $error';
  }

  @override
  String get muteDescription => '将去除视频中的所有音频，仅保留画面';

  @override
  String get muting => '消音中...';

  @override
  String get removeAudio => '去除音频';

  @override
  String get ratioVideo => '视频比例';

  @override
  String get ratioSuccess => '调整成功！';

  @override
  String get ratioFailed => '调整失败';

  @override
  String ratioError(String error) {
    return '调整出错: $error';
  }

  @override
  String get targetRatio => '目标比例:';

  @override
  String get scaleMode => '缩放模式:';

  @override
  String get stretchFit => '拉伸适配';

  @override
  String get cropFill => '裁剪填充';

  @override
  String get letterbox => '黑边填充';

  @override
  String get adjusting => '调整中...';

  @override
  String get startAdjust => '开始调整';

  @override
  String get separateAV => '音视频分离';

  @override
  String get separateComplete => '分离完成！';

  @override
  String get separateFailed => '分离失败，视频可能不包含音视频轨道';

  @override
  String separateError(String error) {
    return '分离出错: $error';
  }

  @override
  String get videoOnlySavedToAlbum => '纯视频已保存到相册';

  @override
  String get saveVideoFailed => '保存视频失败';

  @override
  String saveVideoError(String error) {
    return '保存视频出错: $error';
  }

  @override
  String get cannotGetDownloadDir => '无法获取下载目录';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label 已保存到: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return '$label 文件不存在';
  }

  @override
  String get separateDescription => '将视频的画面和音频分别提取为独立文件';

  @override
  String get separating => '分离中...';

  @override
  String get startSeparate => '开始分离';

  @override
  String get videoOnly => '纯视频（无音频）';

  @override
  String get savedToAlbumLabel => '已保存到相册';

  @override
  String get m4aAudio => 'M4A 音频';

  @override
  String get mp3Audio => 'MP3 音频';

  @override
  String get savedToDownloadsShort => '已保存到 Downloads';

  @override
  String get playMp3Audio => '播放 MP3 音频';

  @override
  String get playM4aAudio => '播放 M4A 音频';

  @override
  String get splitVideo => '视频分割';

  @override
  String get addAtLeastOneSplitPoint => '请至少添加一个分割点';

  @override
  String splitComplete(int count) {
    return '分割完成！共 $count 段';
  }

  @override
  String get splitFailed => '分割失败';

  @override
  String splitError(String error) {
    return '分割出错: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return '已保存 $count 段到相册';
  }

  @override
  String get splitPoints => '分割点:';

  @override
  String get add => '添加';

  @override
  String get noSplitPoints => '暂无分割点，点击添加';

  @override
  String splitPoint(int index) {
    return '分割点 $index:';
  }

  @override
  String willProduceSegments(int count) {
    return '分割后将产生 $count 段:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return '片段 $index: $start-$end ($duration)';
  }

  @override
  String get splitting => '分割中...';

  @override
  String get startSplit => '开始分割';

  @override
  String saveAllSegments(int count) {
    return '保存全部 $count 段';
  }

  @override
  String segment(int index) {
    return '片段 $index';
  }

  @override
  String get privacyTitle => '隐私政策';

  @override
  String get updateDate => '更新日期';

  @override
  String get privacyDate => '2025年1月1日';

  @override
  String get section1Title => '一、信息收集';

  @override
  String get section1Content => '我们非常重视您的隐私保护。本应用在提供服务过程中，仅会收集以下必要信息：';

  @override
  String get section1Item1 => '您主动选择的视频/音频文件（仅用于本地处理，不会上传至任何服务器）';

  @override
  String get section1Item2 => '设备基本信息（用于适配不同设备，不包含个人身份信息）';

  @override
  String get section2Title => '二、信息使用';

  @override
  String get section2Content =>
      '所有音视频处理均在您的设备本地完成，我们不会将您的任何文件或数据上传至远程服务器。收集的设备信息仅用于功能适配和崩溃排查。';

  @override
  String get section3Title => '三、信息存储';

  @override
  String get section3Content =>
      '应用产生的临时文件存储在设备本地临时目录中，处理完成后可由您自行保存或删除。我们不会在服务器端存储您的任何数据。';

  @override
  String get section4Title => '四、信息共享';

  @override
  String get section4Content => '我们不会将您的个人信息出售、交易或以其他方式转让给外部第三方。以下情况除外：';

  @override
  String get section4Item1 => '获得您的明确同意后';

  @override
  String get section4Item2 => '根据法律法规或政府要求';

  @override
  String get section5Title => '五、第三方服务';

  @override
  String get section5Content =>
      '本应用使用了部分第三方SDK来提供服务，这些SDK可能会有其独立的隐私政策。详情请查看\"第三方SDK列表\"页面。';

  @override
  String get section6Title => '六、数据安全';

  @override
  String get section6Content =>
      '我们采取合理的安全措施保护您的信息不被未经授权的访问、使用或泄露。但请注意，互联网环境并非绝对安全，我们建议您妥善保管设备。';

  @override
  String get section7Title => '七、未成年人保护';

  @override
  String get section7Content =>
      '我们非常重视对未成年人个人信息的保护。若您是未满18周岁的未成年人，建议在监护人指导下使用本应用。';

  @override
  String get section8Title => '八、隐私政策变更';

  @override
  String get section8Content => '我们可能会适时修订本隐私政策。当政策发生变更时，我们会在应用内通过弹窗或公告的方式通知您。';

  @override
  String get section9Title => '九、联系我们';

  @override
  String get section9Content =>
      '如您对本隐私政策有任何疑问或建议，请通过以下方式联系我们：\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => '跨平台应用开发框架，用于构建应用界面与交互逻辑';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => '音视频处理核心库，用于视频裁剪、压缩、格式转换等功能';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => '视频播放组件，用于视频预览功能';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc => '文件选择器，用于选择本地视频和音频文件';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc => '相册保存工具，用于将处理后的文件保存到系统相册';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc => '权限管理组件，用于请求存储、相册等系统权限';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc => '路径提供者，用于获取临时目录和文档目录';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => '状态管理库，用于应用内状态共享与管理';

  @override
  String licenseLabel(String license) {
    return '许可证: $license';
  }

  @override
  String videoInitFailed(String error) {
    return '视频初始化失败: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return '选择视频失败: $error';
  }

  @override
  String get premiumVersion => '高级版';

  @override
  String get alreadyPremium => '您已经是高级用户！';

  @override
  String get alreadyPremiumDesc => '感谢您的支持，所有功能已解锁';

  @override
  String get unlockPremium => '解锁高级版';

  @override
  String get unlockPremiumDesc => '一次购买，永久使用所有功能';

  @override
  String get featureUnlimitedSave => '无限次保存到相册';

  @override
  String get featureUnlimitedTools => '所有工具无限制使用';

  @override
  String get featureFreeUpdates => '未来新功能免费更新';

  @override
  String get featureNoAds => '无广告干扰';

  @override
  String get unlockNow => '立即解锁';

  @override
  String get restorePurchases => '恢复购买记录';

  @override
  String get video1LoadFailed => '视频1加载失败';

  @override
  String get video2LoadFailed => '视频2加载失败';

  @override
  String get selectVideoLabel => '选择视频';

  @override
  String get videoChanged => '更换视频';

  @override
  String get saveVideoOnly => '保存纯视频';

  @override
  String get videoOnlySaved => '纯视频已保存';

  @override
  String get sourceFileNotExist => '源文件不存在';

  @override
  String saveLabel(String label) {
    return '保存$label';
  }

  @override
  String labelSaved(String label) {
    return '$label 已保存';
  }

  @override
  String saveLabelError(String error) {
    return '保存出错: $error';
  }

  @override
  String get noImagesExtractedShort => '未能提取到图片';

  @override
  String get reMerge => '重新合并';

  @override
  String get originalLabel => '原始:';

  @override
  String get segmentCount => '段';
}
