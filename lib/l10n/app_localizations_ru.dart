import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => 'Все';

  @override
  String get tabSettings => 'Настройки';

  @override
  String get settingsAbout => 'Настройки и информация';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get lightMode => 'Светлая тема';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get autoMode => 'Авто (17:00)';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get appNameLabel => 'Название приложения';

  @override
  String get versionLabel => 'Версия';

  @override
  String get developerLabel => 'Разработчик';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get viewPrivacyTerms => 'Просмотреть условия конфиденциальности';

  @override
  String get sdkList => 'Список сторонних SDK';

  @override
  String get viewThirdPartyServices => 'Просмотреть сторонние сервисы';

  @override
  String get iapDescription => 'Покупки в приложении';

  @override
  String get viewIapDetails => 'Просмотреть детали покупок и подписок';

  @override
  String get iapSection1Title => '1. Покупки в приложении';

  @override
  String get iapSection1Content => 'Это приложение предлагает покупку \"Premium\" в приложении - это разовая покупка, а не автоматически возобновляемая подписка. После покупки вы навсегда разблокируете все функции, включая: неограниченное сохранение в альбом, неограниченное использование всех инструментов, бесплатные будущие обновления и отсутствие рекламы.';

  @override
  String get iapSection2Title => '2. Оплата и подтверждение';

  @override
  String get iapSection2Content => 'Оплата будет снята с вашего аккаунта Apple ID / Google Play. После подтверждения сумма будет списана с вашего счёта.';

  @override
  String get iapSection3Title => '3. Восстановление покупок';

  @override
  String get iapSection3Content => 'Если вы смените устройство или переустановите приложение, вы можете нажать \"Восстановить покупки\" на странице настроек или магазина, чтобы бесплатно восстановить Premium-доступ без повторной оплаты.';

  @override
  String get iapSection4Title => '4. Отмена и возврат';

  @override
  String get iapSection4Content => 'Это разовая покупка. Возврат средств после покупки не поддерживается. Если вам нужен возврат, пожалуйста, подайте заявку через официальные каналы Apple / Google Play.';

  @override
  String get iapSection5Title => '5. Свяжитесь с нами';

  @override
  String get iapSection5Content => 'Если у вас есть вопросы о покупках в приложении, пожалуйста, свяжитесь с нами:\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => 'Добро пожаловать в ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return 'У вас есть $count бесплатных использований. Каждое сохранение в альбом потребляет 1 использование.';
  }

  @override
  String get welcomeUpgradeHint => 'Обновите до Premium для неограниченного доступа ко всем функциям';

  @override
  String get welcomeGotIt => 'Понятно';

  @override
  String get welcomeUpgrade => 'Обновить до Premium';

  @override
  String freeCountRemaining(int count) {
    return 'Осталось: $count';
  }

  @override
  String get freeCountExhausted => 'Бесплатные использования закончились';

  @override
  String get upgradeToUnlock => 'Обновите до Premium для неограниченного использования';

  @override
  String get openSourceNotice => 'Создано с использованием FFmpeg, Flutter и других технологий с открытым исходным кодом. Спасибо сообществу открытого исходного кода.';

  @override
  String get harmonyDeveloping => 'Версия для HarmonyOS находится в разработке';

  @override
  String get language => 'Язык';

  @override
  String get toolMerge => 'Объединить видео';

  @override
  String get toolMergeDesc => 'Объединить несколько видеофайлов в один';

  @override
  String get toolCut => 'Вырезать видео';

  @override
  String get toolCutDesc => 'Извлечь определённый временной сегмент из видео';

  @override
  String get toolCompress => 'Сжать видео';

  @override
  String get toolCompressDesc => 'Уменьшить размер файла видео';

  @override
  String get toolRatio => 'Соотношение видео';

  @override
  String get toolRatioDesc => 'Изменить соотношение сторон';

  @override
  String get toolMute => 'Без звука';

  @override
  String get toolMuteDesc => 'Удалить звуковую дорожку из видео';

  @override
  String get toolDubbing => 'Озвучка видео';

  @override
  String get toolDubbingDesc => 'Добавить фоновую музыку к видео';

  @override
  String get toolExtract => 'Извлечь изображения';

  @override
  String get toolExtractDesc => 'Извлечь кадры из видео как изображения';

  @override
  String get toolSplit => 'Разделить видео';

  @override
  String get toolSplitDesc => 'Разделить видео на несколько сегментов';

  @override
  String get toolSeparate => 'Разделить аудио/видео';

  @override
  String get toolSeparateDesc => 'Разделить звуковые и видеодорожки';

  @override
  String get toolCrop => 'Обрезать видео';

  @override
  String get toolCropDesc => 'Обрезать область кадра видео';

  @override
  String get toolConvert => 'Конвертировать формат';

  @override
  String get toolConvertDesc => 'Конвертировать формат видеофайла';

  @override
  String toolCountAll(int count) {
    return '$count инструментов · Все';
  }

  @override
  String featureDeveloping(String name) {
    return '$name находится в разработке';
  }

  @override
  String get selectVideoFailed => 'Не удалось выбрать видео';

  @override
  String get selectAudioFailed => 'Не удалось выбрать аудио';

  @override
  String get needAlbumPermission => 'Требуется разрешение на альбом';

  @override
  String get savedToAlbum => 'Сохранено в альбом';

  @override
  String get saveFailed => 'Ошибка сохранения';

  @override
  String saveError(String error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get loading => 'Загрузка...';

  @override
  String get tapToSelectVideo => 'Нажмите, чтобы выбрать видео';

  @override
  String get tapToSelectFirstVideo => 'Выбрать первое видео';

  @override
  String get tapToSelectSecondVideo => 'Выбрать второе видео';

  @override
  String get tapToPreview => 'Нажмите для предпросмотра';

  @override
  String get start => 'Начало';

  @override
  String get end => 'Конец';

  @override
  String get change => 'Изменить';

  @override
  String get reselect => 'Выбрать заново';

  @override
  String get changeVideo => 'Изменить видео';

  @override
  String get saveToAlbum => 'Сохранить в альбом';

  @override
  String get processing => 'Обработка...';

  @override
  String get videoLoadFailed => 'Не удалось загрузить видео';

  @override
  String get previewFailed => 'Ошибка предпросмотра';

  @override
  String get previewInitFailed => 'Не удалось инициализировать предпросмотр';

  @override
  String get mergeVideo => 'Объединение видео';

  @override
  String get selectTwoVideosToMerge => 'Выберите два видео для объединения';

  @override
  String get video1 => 'Видео 1';

  @override
  String get video2 => 'Видео 2';

  @override
  String get selectVideo1 => 'Выбрать видео 1';

  @override
  String get selectVideo2 => 'Выбрать видео 2';

  @override
  String get pleaseSelectTwoVideos => 'Пожалуйста, сначала выберите два видео';

  @override
  String get webNotSupportMerge => 'Объединение не поддерживается в Web';

  @override
  String get video1CropFailed => 'Не удалось обрезать видео 1';

  @override
  String get video2CropFailed => 'Не удалось обрезать видео 2';

  @override
  String get mergeSuccess => 'Объединение успешно!';

  @override
  String get mergeFailed => 'Ошибка объединения';

  @override
  String mergeError(String error) {
    return 'Ошибка объединения: $error';
  }

  @override
  String get merging => 'Объединение...';

  @override
  String get startMerge => 'Начать объединение';

  @override
  String get compressVideo => 'Сжатие видео';

  @override
  String get compressSuccess => 'Сжатие завершено!';

  @override
  String get compressFailed => 'Ошибка сжатия';

  @override
  String compressError(String error) {
    return 'Ошибка сжатия: $error';
  }

  @override
  String originalSize(String size) {
    return 'Оригинальный размер: $size';
  }

  @override
  String compressQuality(int value) {
    return 'Качество сжатия (CRF): $value';
  }

  @override
  String get compressTip => 'Более высокое значение означает большее сжатие и меньшее качество';

  @override
  String get encodeSpeed => 'Скорость кодирования:';

  @override
  String compressedSize(String size) {
    return 'Сжато: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Сохранено: $size ($percent%)';
  }

  @override
  String get compressing => 'Сжатие...';

  @override
  String get startCompress => 'Начать сжатие';

  @override
  String get convertFormat => 'Конвертация формата';

  @override
  String get convertSuccess => 'Конвертация успешна!';

  @override
  String get convertFailed => 'Ошибка конвертации';

  @override
  String convertError(String error) {
    return 'Ошибка конвертации: $error';
  }

  @override
  String get targetFormat => 'Целевой формат:';

  @override
  String get converting => 'Конвертация...';

  @override
  String convertTo(String format) {
    return 'Конвертировать в $format';
  }

  @override
  String get cropVideo => 'Обрезка видео';

  @override
  String get cropSuccess => 'Обрезка успешна!';

  @override
  String get cropFailed => 'Ошибка обрезки';

  @override
  String cropError(String error) {
    return 'Ошибка обрезки: $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'Предпросмотр не удался, но файл был создан';

  @override
  String originalResolution(int width, int height) {
    return 'Оригинал: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Обрезка: ${width}x$height';
  }

  @override
  String get cropDragTip => 'Перетащите зелёную рамку или края для настройки области обрезки, перетащите внутри для перемещения';

  @override
  String get resetCrop => 'Сбросить область обрезки';

  @override
  String get cropping => 'Обрезка...';

  @override
  String get startCrop => 'Начать обрезку';

  @override
  String get cutVideo => 'Вырезка видео';

  @override
  String get cutSuccess => 'Вырезка успешна!';

  @override
  String get cutFailed => 'Ошибка вырезки';

  @override
  String cutError(String error) {
    return 'Ошибка вырезки: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => 'Вырезка завершена (предпросмотр недоступен)';

  @override
  String get videoPreviewUnavailable => 'Предпросмотр видео недоступен';

  @override
  String totalDuration(String duration) {
    return 'Общая длительность: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'Вырезка: $start - $end  ($duration)';
  }

  @override
  String get cutting => 'Вырезка...';

  @override
  String get startCut => 'Начать вырезку';

  @override
  String get dubbingVideo => 'Озвучка видео';

  @override
  String get dubbingSuccess => 'Озвучка успешна!';

  @override
  String get dubbingFailed => 'Ошибка озвучки';

  @override
  String dubbingError(String error) {
    return 'Ошибка озвучки: $error';
  }

  @override
  String get selectVideo => 'Выбрать видео';

  @override
  String get videoSelected => 'Видео выбрано';

  @override
  String get selectAudio => 'Выбрать аудио';

  @override
  String get audioSelected => 'Аудио выбрано';

  @override
  String get dubbingMode => 'Режим озвучки:';

  @override
  String get replaceOriginalAudio => 'Заменить оригинальное аудио';

  @override
  String get replaceAudioHint => 'Отключите для микширования обеих звуковых дорожек';

  @override
  String get dubbing => 'Озвучка...';

  @override
  String get startDubbing => 'Начать озвучку';

  @override
  String get startOver => 'Начать заново';

  @override
  String get extractImages => 'Извлечение изображений';

  @override
  String get startTimeMustBeBeforeEnd => 'Время начала должно быть раньше времени окончания';

  @override
  String extractedCount(int count) {
    return 'Извлечено $count изображений';
  }

  @override
  String get noImagesExtracted => 'Изображения не извлечены, пожалуйста, проверьте видеофайл';

  @override
  String get extractFailed => 'Ошибка извлечения';

  @override
  String extractError(String error) {
    return 'Ошибка извлечения: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return 'Сохранено $count изображений в альбом';
  }

  @override
  String videoDuration(String duration) {
    return 'Длительность видео: $duration';
  }

  @override
  String get startTime => 'Время начала';

  @override
  String get endTime => 'Время окончания';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Диапазон извлечения: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Частота извлечения: $fps кадров/сек';
  }

  @override
  String estimatedImages(int count) {
    return 'Будет извлечено примерно $count изображений';
  }

  @override
  String get extracting => 'Извлечение...';

  @override
  String get startExtract => 'Начать извлечение';

  @override
  String extractedImagesCount(int count) {
    return 'Извлечено $count изображений';
  }

  @override
  String showingFirst30(int count) {
    return 'Показаны первые $count из';
  }

  @override
  String saveAllCount(int count) {
    return 'Сохранить все $count';
  }

  @override
  String get muteVideo => 'Без звука';

  @override
  String get muteSuccess => 'Звук успешно удалён!';

  @override
  String get muteFailed => 'Ошибка удаления звука';

  @override
  String muteError(String error) {
    return 'Ошибка удаления звука: $error';
  }

  @override
  String get muteDescription => 'Весь звук будет удалён, только видеокадры будут сохранены';

  @override
  String get muting => 'Удаление звука...';

  @override
  String get removeAudio => 'Удалить звук';

  @override
  String get ratioVideo => 'Соотношение видео';

  @override
  String get ratioSuccess => 'Соотношение успешно изменено!';

  @override
  String get ratioFailed => 'Ошибка изменения соотношения';

  @override
  String ratioError(String error) {
    return 'Ошибка изменения соотношения: $error';
  }

  @override
  String get targetRatio => 'Целевое соотношение:';

  @override
  String get scaleMode => 'Режим масштабирования:';

  @override
  String get stretchFit => 'Растянуть';

  @override
  String get cropFill => 'Обрезать для заполнения';

  @override
  String get letterbox => 'Письмо в конверте';

  @override
  String get adjusting => 'Изменение...';

  @override
  String get startAdjust => 'Начать изменение';

  @override
  String get separateAV => 'Разделить аудио/видео';

  @override
  String get separateComplete => 'Разделение завершено!';

  @override
  String get separateFailed => 'Ошибка разделения, видео может не содержать звуковых/видеодорожек';

  @override
  String separateError(String error) {
    return 'Ошибка разделения: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Только видео сохранено в альбом';

  @override
  String get saveVideoFailed => 'Ошибка сохранения видео';

  @override
  String saveVideoError(String error) {
    return 'Ошибка сохранения видео: $error';
  }

  @override
  String get cannotGetDownloadDir => 'Не удалось получить папку загрузок';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label сохранено в: Загрузки/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return 'Файл $label не существует';
  }

  @override
  String get separateDescription => 'Извлечь видеокадры и аудио как отдельные файлы';

  @override
  String get separating => 'Разделение...';

  @override
  String get startSeparate => 'Начать разделение';

  @override
  String get videoOnly => 'Только видео (без звука)';

  @override
  String get savedToAlbumLabel => 'Сохранено в альбом';

  @override
  String get m4aAudio => 'Аудио M4A';

  @override
  String get mp3Audio => 'Аудио MP3';

  @override
  String get savedToDownloadsShort => 'Сохранено в загрузки';

  @override
  String get playMp3Audio => 'Воспроизвести MP3 аудио';

  @override
  String get playM4aAudio => 'Воспроизвести M4A аудио';

  @override
  String get splitVideo => 'Разделение видео';

  @override
  String get addAtLeastOneSplitPoint => 'Пожалуйста, добавьте хотя бы одну точку разделения';

  @override
  String splitComplete(int count) {
    return 'Разделение завершено! $count сегментов';
  }

  @override
  String get splitFailed => 'Ошибка разделения';

  @override
  String splitError(String error) {
    return 'Ошибка разделения: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return 'Сохранено $count сегментов в альбом';
  }

  @override
  String get splitPoints => 'Точки разделения:';

  @override
  String get add => 'Добавить';

  @override
  String get noSplitPoints => 'Нет точек разделения, нажмите для добавления';

  @override
  String splitPoint(int index) {
    return 'Точка разделения $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'Будет создано $count сегментов после разделения:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Сегмент $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'Разделение...';

  @override
  String get startSplit => 'Начать разделение';

  @override
  String saveAllSegments(int count) {
    return 'Сохранить все $count сегментов';
  }

  @override
  String segment(int index) {
    return 'Сегмент $index';
  }

  @override
  String get privacyTitle => 'Политика конфиденциальности';

  @override
  String get updateDate => 'Дата обновления';

  @override
  String get privacyDate => '1 января 2025 года';

  @override
  String get section1Title => '1. Сбор информации';

  @override
  String get section1Content => 'Мы очень серьёзно относимся к вашей конфиденциальности. Это приложение собирает только следующую необходимую информацию для предоставления услуг:';

  @override
  String get section1Item1 => 'Видео/аудио файлы, которые вы активно выбираете (используются только для локальной обработки, никогда не загружаются на какой-либо сервер)';

  @override
  String get section1Item2 => 'Основная информация об устройстве (для адаптации устройства, не содержит персональных идентификационных данных)';

  @override
  String get section2Title => '2. Использование информации';

  @override
  String get section2Content => 'Вся обработка аудио/видео выполняется локально на вашем устройстве. Мы никогда не загружаем ваши файлы или данные на удалённые серверы. Собранная информация об устройстве используется только для адаптации функций и расследования сбоев.';

  @override
  String get section3Title => '3. Хранение информации';

  @override
  String get section3Content => 'Временные файлы, создаваемые приложением, хранятся в локальном временном каталоге устройства. Вы можете сохранять или удалять их по своему усмотрению после обработки. Мы не храним ваши данные на серверах.';

  @override
  String get section4Title => '4. Обмен информацией';

  @override
  String get section4Content => 'Мы не будем продавать, обменивать или иным образом передавать вашу личную информацию третьим лицам, за исключением следующих случаев:';

  @override
  String get section4Item1 => 'С вашего явного согласия';

  @override
  String get section4Item2 => 'По требованию закона или государственного постановления';

  @override
  String get section5Title => '5. Услуги третьих лиц';

  @override
  String get section5Content => 'Это приложение использует некоторые сторонние SDK для предоставления услуг, которые могут иметь собственные политики конфиденциальности. Подробности см. на странице \"Список сторонних SDK\".';

  @override
  String get section6Title => '6. Безопасность данных';

  @override
  String get section6Content => 'Мы принимаем разумные меры безопасности для защиты вашей информации от несанкционированного доступа, использования или раскрытия. Однако учтите, что Интернет не является абсолютно безопасным. Мы рекомендуем поддерживать безопасность вашего устройства.';

  @override
  String get section7Title => '7. Защита несовершеннолетних';

  @override
  String get section7Content => 'Мы уделяем большое внимание защите персональных данных несовершеннолетних. Если вам меньше 18 лет, мы рекомендуем использовать это приложение под присмотром родителя или опекуна.';

  @override
  String get section8Title => '8. Изменения политики конфиденциальности';

  @override
  String get section8Content => 'Мы можем время от времени пересматривать эту политику конфиденциальности. При внесении изменений мы уведомим вас через всплывающие окна в приложении или объявления.';

  @override
  String get section9Title => '9. Свяжитесь с нами';

  @override
  String get section9Content => 'Если у вас есть вопросы или предложения относительно этой политики конфиденциальности, пожалуйста, свяжитесь с нами:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'Кроссплатформенный фреймворк для разработки приложений, используемый для построения UI и взаимодействий';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => 'Базовая библиотека для обработки аудио/видео для обрезки, сжатия, конвертации форматов и т.д.';

  @override
  String get sdkVideoPlayerTitle => 'Видеоплеер';

  @override
  String get sdkVideoPlayerDesc => 'Компонент воспроизведения видео для предпросмотра';

  @override
  String get sdkFilePickerTitle => 'Выбор файлов';

  @override
  String get sdkFilePickerDesc => 'Выбор файлов для выбора локальных видео и аудио файлов';

  @override
  String get sdkGallerySaverTitle => 'Сохранение в галерею';

  @override
  String get sdkGallerySaverDesc => 'Инструмент сохранения в альбом для сохранения обработанных файлов в системный альбом';

  @override
  String get sdkPermissionTitle => 'Обработчик разрешений';

  @override
  String get sdkPermissionDesc => 'Компонент управления разрешениями для запроса разрешений хранилища, альбома и других системных разрешений';

  @override
  String get sdkPathProviderTitle => 'Провайдер путей';

  @override
  String get sdkPathProviderDesc => 'Провайдер путей для получения временных каталогов и документов';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'Библиотека управления состоянием для совместного использования и управления состоянием приложения';

  @override
  String licenseLabel(String license) {
    return 'Лицензия: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Не удалось инициализировать видео: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Не удалось выбрать видео: $error';
  }

  @override
  String get premiumVersion => 'Premium';

  @override
  String get alreadyPremium => 'Вы уже пользователь Premium!';

  @override
  String get alreadyPremiumDesc => 'Спасибо за поддержку, все функции разблокированы';

  @override
  String get unlockPremium => 'Разблокировать Premium';

  @override
  String get unlockPremiumDesc => 'Разовая покупка, постоянный доступ ко всем функциям';

  @override
  String get featureUnlimitedSave => 'Неограниченное сохранение в альбом';

  @override
  String get featureUnlimitedTools => 'Неограниченное использование всех инструментов';

  @override
  String get featureFreeUpdates => 'Бесплатные будущие обновления';

  @override
  String get featureNoAds => 'Отсутствие рекламы';

  @override
  String get unlockNow => 'Разблокировать сейчас';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get video1LoadFailed => 'Не удалось загрузить видео 1';

  @override
  String get video2LoadFailed => 'Не удалось загрузить видео 2';

  @override
  String get selectVideoLabel => 'Выбрать видео';

  @override
  String get videoChanged => 'Изменить видео';

  @override
  String get saveVideoOnly => 'Сохранить только видео';

  @override
  String get videoOnlySaved => 'Только видео сохранено';

  @override
  String get sourceFileNotExist => 'Исходный файл не существует';

  @override
  String saveLabel(String label) {
    return 'Сохранить $label';
  }

  @override
  String labelSaved(String label) {
    return '$label сохранено';
  }

  @override
  String saveLabelError(String error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get noImagesExtractedShort => 'Изображения не извлечены';

  @override
  String get reMerge => 'Повторное объединение';

  @override
  String get originalLabel => 'Оригинал:';

  @override
  String get segmentCount => 'сегментов';
}
