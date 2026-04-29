import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => 'الكل';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get settingsAbout => 'الإعدادات والمعلومات';

  @override
  String get appearance => 'المظهر';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get autoMode => 'تلقائي (5 مساءً)';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get appNameLabel => 'اسم التطبيق';

  @override
  String get versionLabel => 'الإصدار';

  @override
  String get developerLabel => 'المطور';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get viewPrivacyTerms => 'عرض شروط الخصوصية';

  @override
  String get sdkList => 'قائمة حزم SDK الخارجية';

  @override
  String get viewThirdPartyServices => 'عرض خدمات الطرف الثالث';

  @override
  String get iapDescription => 'عمليات الشراء داخل التطبيق';

  @override
  String get viewIapDetails => 'عرض تفاصيل الشراء والاشتراك داخل التطبيق';

  @override
  String get iapSection1Title => '1. عناصر الشراء داخل التطبيق';

  @override
  String get iapSection1Content => 'يقدم هذا التطبيق شراءً داخل التطبيق \"Premium\"، وهو شراء لمرة واحدة وليس اشتراكًا تجديديًا تلقائيًا. بعد الشراء، ستقوم بإلغاء قفل جميع الميزات بشكل دائم، بما في ذلك: عمليات حفظ غير محدودة للألبوم، واستخدام غير مقيد لجميع الأدوات، وتحديثات مستقبلية مجانية، وتجربة بدون إعلانات.';

  @override
  String get iapSection2Title => '2. الدفع والتأكيد';

  @override
  String get iapSection2Content => 'سيتم خصم المبلغ من حساب Apple ID / Google Play الخاص بك. بمجرد التأكيد، سيتم خصم المبلغ من حسابك.';

  @override
  String get iapSection3Title => '3. استعادة المشتريات';

  @override
  String get iapSection3Content => 'إذا قمت بتغيير الأجهزة أو إعادة تثبيت التطبيق، يمكنك النقر على \"استعادة المشتريات\" في صفحة الإعدادات أو المتجر لاستعادة وصول Premium مجانًا، دون الدفع مرة أخرى.';

  @override
  String get iapSection4Title => '4. الإلغاء والاسترداد';

  @override
  String get iapSection4Content => 'هذا شراء لمرة واحدة. لا يتم دعم استرداد الأموال بعد الشراء. إذا كنت بحاجة إلى استرداد أموال، يرجى التقدم عبر القنوات الرسمية لـ Apple / Google Play.';

  @override
  String get iapSection5Title => '5. تواصل معنا';

  @override
  String get iapSection5Content => 'إذا كانت لديك أي أسئلة حول عمليات الشراء داخل التطبيق، يرجى التواصل مع:\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => 'مرحبًا بك في ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return 'لديك $count استخدامات مجانية. كل حفظ في الألبوم يستهلك استخدامًا واحدًا.';
  }

  @override
  String get welcomeUpgradeHint => 'الترقية إلى Premium للحصول على وصول غير محدود لجميع الميزات';

  @override
  String get welcomeGotIt => 'فهمت';

  @override
  String get welcomeUpgrade => 'الترقية إلى Premium';

  @override
  String freeCountRemaining(int count) {
    return '$count متبقي';
  }

  @override
  String get freeCountExhausted => 'استنفدت الاستخدامات المجانية';

  @override
  String get upgradeToUnlock => 'الترقية إلى Premium لاستخدام غير محدود';

  @override
  String get openSourceNotice => 'مبني باستخدام FFmpeg وFlutter وتقنيات مفتوحة المصدر أخرى. شكرًا لمجتمع المصادر المفتوحة.';

  @override
  String get harmonyDeveloping => 'نسخة HarmonyOS قيد التطوير';

  @override
  String get language => 'اللغة';

  @override
  String get toolMerge => 'دمج مقاطع الفيديو';

  @override
  String get toolMergeDesc => 'دمج عدة ملفات فيديو في ملف واحد';

  @override
  String get toolCut => 'قص الفيديو';

  @override
  String get toolCutDesc => 'استخراج مقطع زمني محدد من الفيديو';

  @override
  String get toolCompress => 'ضغط الفيديو';

  @override
  String get toolCompressDesc => 'تقليل حجم ملف الفيديو';

  @override
  String get toolRatio => 'نسبة الفيديو';

  @override
  String get toolRatioDesc => 'تعديل نسبة الأبعاد';

  @override
  String get toolMute => 'كتم الفيديو';

  @override
  String get toolMuteDesc => 'إزالة المسار الصوتي من الفيديو';

  @override
  String get toolDubbing => 'التعليق الصوتي';

  @override
  String get toolDubbingDesc => 'إضافة موسيقى خلفية إلى الفيديو';

  @override
  String get toolExtract => 'استخراج الصور';

  @override
  String get toolExtractDesc => 'استخراج الإطارات من الفيديو كصور';

  @override
  String get toolSplit => 'تقسيم الفيديو';

  @override
  String get toolSplitDesc => 'تقسيم الفيديو إلى عدة مقاطع';

  @override
  String get toolSeparate => 'فصل الصوت/الصورة';

  @override
  String get toolSeparateDesc => 'فصل المسارات الصوتية والمرئية';

  @override
  String get toolCrop => 'قص الفيديو';

  @override
  String get toolCropDesc => 'قص منطقة إطار الفيديو';

  @override
  String get toolConvert => 'تحويل الصيغة';

  @override
  String get toolConvertDesc => 'تحويل صيغة ملف الفيديو';

  @override
  String toolCountAll(int count) {
    return '$count أدوات · الكل';
  }

  @override
  String featureDeveloping(String name) {
    return '$name قيد التطوير';
  }

  @override
  String get selectVideoFailed => 'فشل في اختيار الفيديو';

  @override
  String get selectAudioFailed => 'فشل في اختيار الصوت';

  @override
  String get needAlbumPermission => 'مطلوب إذن الألبوم';

  @override
  String get savedToAlbum => 'تم الحفظ في الألبوم';

  @override
  String get saveFailed => 'فشل الحفظ';

  @override
  String saveError(String error) {
    return 'خطأ في الحفظ: $error';
  }

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get tapToSelectVideo => 'انقر لاختيار فيديو';

  @override
  String get tapToSelectFirstVideo => 'انقر لاختيار الفيديو الأول';

  @override
  String get tapToSelectSecondVideo => 'انقر لاختيار الفيديو الثاني';

  @override
  String get tapToPreview => 'انقر للمعاينة';

  @override
  String get start => 'البداية';

  @override
  String get end => 'النهاية';

  @override
  String get change => 'تغيير';

  @override
  String get reselect => 'إعادة الاختيار';

  @override
  String get changeVideo => 'تغيير الفيديو';

  @override
  String get saveToAlbum => 'حفظ في الألبوم';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get videoLoadFailed => 'فشل تحميل الفيديو';

  @override
  String get previewFailed => 'فشلت المعاينة';

  @override
  String get previewInitFailed => 'فشل تهيئة المعاينة';

  @override
  String get mergeVideo => 'دمج مقاطع الفيديو';

  @override
  String get selectTwoVideosToMerge => 'اختر فيديوهين لدمجهما';

  @override
  String get video1 => 'الفيديو 1';

  @override
  String get video2 => 'الفيديو 2';

  @override
  String get selectVideo1 => 'اختر الفيديو 1';

  @override
  String get selectVideo2 => 'اختر الفيديو 2';

  @override
  String get pleaseSelectTwoVideos => 'يرجى اختيار فيديوهين أولاً';

  @override
  String get webNotSupportMerge => 'الدمج غير مدعوم على الويب';

  @override
  String get video1CropFailed => 'فشل قص الفيديو 1';

  @override
  String get video2CropFailed => 'فشل قص الفيديو 2';

  @override
  String get mergeSuccess => 'تم الدمج بنجاح!';

  @override
  String get mergeFailed => 'فشل الدمج';

  @override
  String mergeError(String error) {
    return 'خطأ في الدمج: $error';
  }

  @override
  String get merging => 'جارٍ الدمج...';

  @override
  String get startMerge => 'بدء الدمج';

  @override
  String get compressVideo => 'ضغط الفيديو';

  @override
  String get compressSuccess => 'اكتمل الضغط!';

  @override
  String get compressFailed => 'فشل الضغط';

  @override
  String compressError(String error) {
    return 'خطأ في الضغط: $error';
  }

  @override
  String originalSize(String size) {
    return 'الحجم الأصلي: $size';
  }

  @override
  String compressQuality(int value) {
    return 'جودة الضغط (CRF): $value';
  }

  @override
  String get compressTip => 'كلما ارتفعت القيمة زاد الضغط وانخفضت الجودة';

  @override
  String get encodeSpeed => 'سرعة الترميز:';

  @override
  String compressedSize(String size) {
    return 'مضغوط: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'تم التوفير: $size ($percent%)';
  }

  @override
  String get compressing => 'جارٍ الضغط...';

  @override
  String get startCompress => 'بدء الضغط';

  @override
  String get convertFormat => 'تحويل الصيغة';

  @override
  String get convertSuccess => 'تم التحويل بنجاح!';

  @override
  String get convertFailed => 'فشل التحويل';

  @override
  String convertError(String error) {
    return 'خطأ في التحويل: $error';
  }

  @override
  String get targetFormat => 'الصيغة الهدف:';

  @override
  String get converting => 'جارٍ التحويل...';

  @override
  String convertTo(String format) {
    return 'تحويل إلى $format';
  }

  @override
  String get cropVideo => 'قص الفيديو';

  @override
  String get cropSuccess => 'تم القص بنجاح!';

  @override
  String get cropFailed => 'فشل القص';

  @override
  String cropError(String error) {
    return 'خطأ في القص: $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'فشلت المعاينة، لكن تم إنشاء الملف';

  @override
  String originalResolution(int width, int height) {
    return 'الأصلي: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'القص: ${width}x$height';
  }

  @override
  String get cropDragTip => 'اسحب الصندوق الأخضر أو الحواف لتعديل منطقة القص، اسحب من الداخل للتحريك';

  @override
  String get resetCrop => 'إعادة تعيين منطقة القص';

  @override
  String get cropping => 'جارٍ القص...';

  @override
  String get startCrop => 'بدء القص';

  @override
  String get cutVideo => 'قص الفيديو';

  @override
  String get cutSuccess => 'تم القص بنجاح!';

  @override
  String get cutFailed => 'فشل القص';

  @override
  String cutError(String error) {
    return 'خطأ في القص: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => 'اكتمل القص (المعاينة غير متوفرة)';

  @override
  String get videoPreviewUnavailable => 'معاينة الفيديو غير متوفرة';

  @override
  String totalDuration(String duration) {
    return 'المدة الإجمالية: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'القص: $start - $end  ($duration)';
  }

  @override
  String get cutting => 'جارٍ القص...';

  @override
  String get startCut => 'بدء القص';

  @override
  String get dubbingVideo => 'التعليق الصوتي';

  @override
  String get dubbingSuccess => 'تم التعليق الصوتي بنجاح!';

  @override
  String get dubbingFailed => 'فشل التعليق الصوتي';

  @override
  String dubbingError(String error) {
    return 'خطأ في التعليق الصوتي: $error';
  }

  @override
  String get selectVideo => 'اختر فيديو';

  @override
  String get videoSelected => 'تم اختيار الفيديو';

  @override
  String get selectAudio => 'اختر صوتًا';

  @override
  String get audioSelected => 'تم اختيار الصوت';

  @override
  String get dubbingMode => 'وضع التعليق الصوتي:';

  @override
  String get replaceOriginalAudio => 'استبدال الصوت الأصلي';

  @override
  String get replaceAudioHint => 'أوقف الخلط لخلط المسارين الصوتيين معًا';

  @override
  String get dubbing => 'جارٍ التعليق الصوتي...';

  @override
  String get startDubbing => 'بدء التعليق الصوتي';

  @override
  String get startOver => 'البدء من جديد';

  @override
  String get extractImages => 'استخراج الصور';

  @override
  String get startTimeMustBeBeforeEnd => 'يجب أن يكون وقت البداية قبل وقت النهاية';

  @override
  String extractedCount(int count) {
    return 'تم استخراج $count صورة';
  }

  @override
  String get noImagesExtracted => 'لم يتم استخراج صور، يرجى التحقق من ملف الفيديو';

  @override
  String get extractFailed => 'فشل الاستخراج';

  @override
  String extractError(String error) {
    return 'خطأ في الاستخراج: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return 'تم حفظ $count صورة في الألبوم';
  }

  @override
  String videoDuration(String duration) {
    return 'مدة الفيديو: $duration';
  }

  @override
  String get startTime => 'وقت البداية';

  @override
  String get endTime => 'وقت النهاية';

  @override
  String extractRange(String start, String end, String duration) {
    return 'نطاق الاستخراج: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'معدل الاستخراج: $fps إطار/ثانية';
  }

  @override
  String estimatedImages(int count) {
    return 'سيتم استخراج حوالي $count صورة';
  }

  @override
  String get extracting => 'جارٍ الاستخراج...';

  @override
  String get startExtract => 'بدء الاستخراج';

  @override
  String extractedImagesCount(int count) {
    return 'تم استخراج $count صورة';
  }

  @override
  String showingFirst30(int count) {
    return 'عرض أول $count من';
  }

  @override
  String saveAllCount(int count) {
    return 'حفظ الكل $count';
  }

  @override
  String get muteVideo => 'كتم الفيديو';

  @override
  String get muteSuccess => 'تم كتم الصوت بنجاح!';

  @override
  String get muteFailed => 'فشل كتم الصوت';

  @override
  String muteError(String error) {
    return 'خطأ في كتم الصوت: $error';
  }

  @override
  String get muteDescription => 'سيتم إزالة كل الصوت، مع الاحتفاظ بإطارات الفيديو فقط';

  @override
  String get muting => 'جارٍ كتم الصوت...';

  @override
  String get removeAudio => 'إزالة الصوت';

  @override
  String get ratioVideo => 'نسبة الفيديو';

  @override
  String get ratioSuccess => 'تم تعديل النسبة بنجاح!';

  @override
  String get ratioFailed => 'فشل تعديل النسبة';

  @override
  String ratioError(String error) {
    return 'خطأ في تعديل النسبة: $error';
  }

  @override
  String get targetRatio => 'النسبة الهدف:';

  @override
  String get scaleMode => 'وضع القياس:';

  @override
  String get stretchFit => 'ملاءمةStretch';

  @override
  String get cropFill => 'تعبئة القص';

  @override
  String get letterbox => 'صندوق الرسائل';

  @override
  String get adjusting => 'جارٍ التعديل...';

  @override
  String get startAdjust => 'بدء التعديل';

  @override
  String get separateAV => 'فصل الصوت/الصورة';

  @override
  String get separateComplete => 'اكتمل الفصل!';

  @override
  String get separateFailed => 'فشل الفصل، قد لا يحتوي الفيديو على مسارات صوتية/مرئية';

  @override
  String separateError(String error) {
    return 'خطأ في الفصل: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'تم حفظ الفيديو فقط في الألبوم';

  @override
  String get saveVideoFailed => 'فشل حفظ الفيديو';

  @override
  String saveVideoError(String error) {
    return 'خطأ في حفظ الفيديو: $error';
  }

  @override
  String get cannotGetDownloadDir => 'لا يمكن الحصول على مجلد التنزيلات';

  @override
  String savedToDownloads(String label, String fileName) {
    return 'تم حفظ $label في: التنزيلات/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return 'ملف $label غير موجود';
  }

  @override
  String get separateDescription => 'استخراج إطارات الفيديو والصوت كملفات منفصلة';

  @override
  String get separating => 'جارٍ الفصل...';

  @override
  String get startSeparate => 'بدء الفصل';

  @override
  String get videoOnly => 'فيديو فقط (بدون صوت)';

  @override
  String get savedToAlbumLabel => 'تم الحفظ في الألبوم';

  @override
  String get m4aAudio => 'صوت M4A';

  @override
  String get mp3Audio => 'صوت MP3';

  @override
  String get savedToDownloadsShort => 'تم الحفظ في التنزيلات';

  @override
  String get playMp3Audio => 'تشغيل صوت MP3';

  @override
  String get playM4aAudio => 'تشغيل صوت M4A';

  @override
  String get splitVideo => 'تقسيم الفيديو';

  @override
  String get addAtLeastOneSplitPoint => 'يرجى إضافة نقطة تقسيم واحدة على الأقل';

  @override
  String splitComplete(int count) {
    return 'اكتمل التقسيم! $count مقاطع';
  }

  @override
  String get splitFailed => 'فشل التقسيم';

  @override
  String splitError(String error) {
    return 'خطأ في التقسيم: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return 'تم حفظ $count مقطع في الألبوم';
  }

  @override
  String get splitPoints => 'نقاط التقسيم:';

  @override
  String get add => 'إضافة';

  @override
  String get noSplitPoints => 'لا توجد نقاط تقسيم، انقر للإضافة';

  @override
  String splitPoint(int index) {
    return 'نقطة التقسيم $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'سيتم إنتاج $count مقطع بعد التقسيم:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'المقطع $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'جارٍ التقسيم...';

  @override
  String get startSplit => 'بدء التقسيم';

  @override
  String saveAllSegments(int count) {
    return 'حفظ جميع المقاطع $count';
  }

  @override
  String segment(int index) {
    return 'المقطع $index';
  }

  @override
  String get privacyTitle => 'سياسة الخصوصية';

  @override
  String get updateDate => 'تاريخ التحديث';

  @override
  String get privacyDate => '1 يناير 2025';

  @override
  String get section1Title => '1. جمع المعلومات';

  @override
  String get section1Content => 'نحن نأخذ خصوصيتك على محمل الجد. يجمع هذا التطبيق فقط المعلومات التالية الضرورية لتقديم الخدمة:';

  @override
  String get section1Item1 => 'ملفات الفيديو/الصوت التي تختارها بنشاط (تُستخدم فقط للمعالجة المحلية، ولا تُرفع إلى أي خادم)';

  @override
  String get section1Item2 => 'معلومات الجهاز الأساسية (لمواءمة الجهاز، لا تحتوي على معلومات هوية شخصية)';

  @override
  String get section2Title => '2. استخدام المعلومات';

  @override
  String get section2Content => 'يتم إكمال جميع معالجة الصوت/الفيديو محليًا على جهازك. لن نرفع أبدًا أيًا من ملفاتك أو بياناتك إلى خوادم بعيدة. تُستخدم معلومات الجهاز المجمعة فقط لتكييف الميزات وتحليل الأعطال.';

  @override
  String get section3Title => '3. تخزين المعلومات';

  @override
  String get section3Content => 'الملفات المؤقتة التي ينشئها التطبيق مخزنة في الدليل المؤقت المحلي للجهاز. يمكنك حفظها أو حذفها حسب رغبتك بعد المعالجة. لا نخزن أيًا من بياناتك على الخوادم.';

  @override
  String get section4Title => '4. مشاركة المعلومات';

  @override
  String get section4Content => 'لن نبيع أو نتداول أو ننقل معلوماتك الشخصية إلى أطراف ثالثة، باستثناء الحالات التالية:';

  @override
  String get section4Item1 => 'بموافقة صريحة منك';

  @override
  String get section4Item2 => 'كما هو مطلوب بموجب القانون أو أمر حكومي';

  @override
  String get section5Title => '5. خدمات الطرف الثالث';

  @override
  String get section5Content => 'يستخدم هذا التطبيق بعض حزم SDK التابعة لجهات خارجية لتقديم الخدمات، والتي قد تكون لها سياسات خصوصية خاصة بها. يرجى الاطلاع على صفحة \"قائمة حزم SDK التابعة لجهات خارجية\" للتفاصيل.';

  @override
  String get section6Title => '6. أمان البيانات';

  @override
  String get section6Content => 'نتخذ تدابير أمنية معقولة لحماية معلوماتك من الوصول أو الاستخدام أو الإفصاح غير المصرح به. ومع ذلك، يرجى ملاحظة أن الإنترنت ليس آمنًا تمامًا. نوصي بالحفاظ على أمان جهازك.';

  @override
  String get section7Title => '7. حماية القاصرين';

  @override
  String get section7Content => 'نولي أهمية كبيرة لحماية المعلومات الشخصية للقاصرين. إذا كان عمرك أقل من 18 عامًا، نوصي باستخدام هذا التطبيق تحت إشراف ولي الأمر.';

  @override
  String get section8Title => '8. تغييرات سياسة الخصوصية';

  @override
  String get section8Content => 'قد نقوم بمراجعة سياسة الخصوصية هذه من وقت لآخر. عند حدوث تغييرات، سنخبرك عبر النوافذ المنبثقة داخل التطبيق أو الإعلانات.';

  @override
  String get section9Title => '9. تواصل معنا';

  @override
  String get section9Content => 'إذا كانت لديك أي أسئلة أو اقتراحات حول سياسة الخصوصية هذه، يرجى التواصل معنا على:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'إطار عمل تطوير تطبيقات متعددة المنصات لبناء واجهة المستخدم والتفاعلات';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => 'مكتبة أساسية لمعالجة الصوت/الفيديو لقص وضغط وتحويل صيغ الفيديو وغيرها';

  @override
  String get sdkVideoPlayerTitle => 'مشغل الفيديو';

  @override
  String get sdkVideoPlayerDesc => 'مكون تشغيل الفيديو لمعاينة الفيديو';

  @override
  String get sdkFilePickerTitle => 'منتقي الملفات';

  @override
  String get sdkFilePickerDesc => 'منتقي الملفات لاختيار ملفات الفيديو والصوت المحلية';

  @override
  String get sdkGallerySaverTitle => 'حافظ الألبوم';

  @override
  String get sdkGallerySaverDesc => 'أداة حفظ الألبوم لحفظ الملفات المعالجة في ألبوم النظام';

  @override
  String get sdkPermissionTitle => 'معالج الأذونات';

  @override
  String get sdkPermissionDesc => 'مكون إدارة الأذونات لطلب أذونات التخزين والألبوم وغيرها من أذونات النظام';

  @override
  String get sdkPathProviderTitle => 'موفر المسار';

  @override
  String get sdkPathProviderDesc => 'موفر المسار للحصول على الأدلة المؤقتة والمستندات';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'مكتبة إدارة الحالة لمشاركة وإدارة حالة التطبيق';

  @override
  String licenseLabel(String license) {
    return 'الترخيص: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'فشل تهيئة الفيديو: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'فشل اختيار الفيديو: $error';
  }

  @override
  String get premiumVersion => 'Premium';

  @override
  String get alreadyPremium => 'أنت بالفعل مستخدم Premium!';

  @override
  String get alreadyPremiumDesc => 'شكرًا لدعمك، جميع الميزات مفتوحة';

  @override
  String get unlockPremium => 'فتح Premium';

  @override
  String get unlockPremiumDesc => 'شراء لمرة واحدة، وصول دائم لجميع الميزات';

  @override
  String get featureUnlimitedSave => 'حفظ غير محدود في الألبوم';

  @override
  String get featureUnlimitedTools => 'استخدام غير مقيد لجميع الأدوات';

  @override
  String get featureFreeUpdates => 'تحديثات مستقبلية مجانية';

  @override
  String get featureNoAds => 'تجربة بدون إعلانات';

  @override
  String get unlockNow => 'فتح الآن';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get video1LoadFailed => 'فشل تحميل الفيديو 1';

  @override
  String get video2LoadFailed => 'فشل تحميل الفيديو 2';

  @override
  String get selectVideoLabel => 'اختر فيديو';

  @override
  String get videoChanged => 'تغيير الفيديو';

  @override
  String get saveVideoOnly => 'حفظ الفيديو فقط';

  @override
  String get videoOnlySaved => 'تم حفظ الفيديو فقط';

  @override
  String get sourceFileNotExist => 'الملف المصدر غير موجود';

  @override
  String saveLabel(String label) {
    return 'حفظ $label';
  }

  @override
  String labelSaved(String label) {
    return 'تم حفظ $label';
  }

  @override
  String saveLabelError(String error) {
    return 'خطأ في الحفظ: $error';
  }

  @override
  String get noImagesExtractedShort => 'لم يتم استخراج صور';

  @override
  String get reMerge => 'إعادة الدمج';

  @override
  String get originalLabel => 'الأصلي:';

  @override
  String get segmentCount => 'مقاطع';
}
