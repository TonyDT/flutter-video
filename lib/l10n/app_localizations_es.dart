// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Video ToolKit';

  @override
  String get tabAll => 'Todo';

  @override
  String get tabSettings => 'Ajustes';

  @override
  String get settingsAbout => 'Ajustes y Acerca de';

  @override
  String get appearance => 'Apariencia';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get aboutApp => 'Acerca de la app';

  @override
  String get appNameLabel => 'Nombre de la app';

  @override
  String get versionLabel => 'Versión';

  @override
  String get developerLabel => 'Desarrollador';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get viewPrivacyTerms => 'Ver términos de privacidad';

  @override
  String get sdkList => 'Lista de SDK de terceros';

  @override
  String get viewThirdPartyServices => 'Ver servicios de terceros';

  @override
  String get openSourceNotice =>
      'Desarrollado con FFmpeg, Flutter y otras tecnologías de código abierto. Gracias a la comunidad de código abierto.';

  @override
  String get harmonyDeveloping => 'La versión HarmonyOS está en desarrollo';

  @override
  String get language => 'Idioma';

  @override
  String get toolMerge => 'Fusionar vídeos';

  @override
  String get toolMergeDesc => 'Fusionar varios archivos de vídeo en uno';

  @override
  String get toolCut => 'Cortar vídeo';

  @override
  String get toolCutDesc =>
      'Extraer un segmento de tiempo específico del vídeo';

  @override
  String get toolCompress => 'Comprimir vídeo';

  @override
  String get toolCompressDesc => 'Reducir el tamaño del archivo de vídeo';

  @override
  String get toolRatio => 'Relación de aspecto';

  @override
  String get toolRatioDesc => 'Ajustar la relación de aspecto';

  @override
  String get toolMute => 'Silenciar vídeo';

  @override
  String get toolMuteDesc => 'Eliminar la pista de audio del vídeo';

  @override
  String get toolDubbing => 'Doblar vídeo';

  @override
  String get toolDubbingDesc => 'Añadir música de fondo al vídeo';

  @override
  String get toolExtract => 'Extraer imágenes';

  @override
  String get toolExtractDesc => 'Extraer fotogramas del vídeo como imágenes';

  @override
  String get toolSplit => 'Dividir vídeo';

  @override
  String get toolSplitDesc => 'Dividir el vídeo en varios segmentos';

  @override
  String get toolSeparate => 'Separar A/V';

  @override
  String get toolSeparateDesc => 'Separar las pistas de audio y vídeo';

  @override
  String get toolCrop => 'Recortar vídeo';

  @override
  String get toolCropDesc => 'Recortar el área del fotograma del vídeo';

  @override
  String get toolConvert => 'Convertir formato';

  @override
  String get toolConvertDesc => 'Convertir el formato del archivo de vídeo';

  @override
  String toolCountAll(int count) {
    return '$count herramientas · Todo';
  }

  @override
  String featureDeveloping(String name) {
    return '$name está en desarrollo';
  }

  @override
  String get selectVideoFailed => 'Error al seleccionar vídeo';

  @override
  String get selectAudioFailed => 'Error al seleccionar audio';

  @override
  String get needAlbumPermission => 'Se necesita permiso del álbum';

  @override
  String get savedToAlbum => 'Guardado en el álbum';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String saveError(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get loading => 'Cargando...';

  @override
  String get tapToSelectVideo => 'Toca para seleccionar un vídeo';

  @override
  String get tapToSelectFirstVideo => 'Toca para seleccionar el primer vídeo';

  @override
  String get tapToSelectSecondVideo => 'Toca para seleccionar el segundo vídeo';

  @override
  String get tapToPreview => 'Toca para previsualizar';

  @override
  String get start => 'Inicio';

  @override
  String get end => 'Fin';

  @override
  String get change => 'Cambiar';

  @override
  String get reselect => 'Reseleccionar';

  @override
  String get changeVideo => 'Cambiar vídeo';

  @override
  String get saveToAlbum => 'Guardar en álbum';

  @override
  String get processing => 'Procesando...';

  @override
  String get videoLoadFailed => 'Error al cargar el vídeo';

  @override
  String get previewFailed => 'Error en la vista previa';

  @override
  String get previewInitFailed => 'Error al inicializar la vista previa';

  @override
  String get mergeVideo => 'Fusionar vídeos';

  @override
  String get selectTwoVideosToMerge => 'Selecciona dos vídeos para fusionar';

  @override
  String get video1 => 'Vídeo 1';

  @override
  String get video2 => 'Vídeo 2';

  @override
  String get selectVideo1 => 'Seleccionar vídeo 1';

  @override
  String get selectVideo2 => 'Seleccionar vídeo 2';

  @override
  String get pleaseSelectTwoVideos =>
      'Por favor, selecciona dos vídeos primero';

  @override
  String get webNotSupportMerge => 'La fusión no es compatible en la Web';

  @override
  String get video1CropFailed => 'Error al recortar el vídeo 1';

  @override
  String get video2CropFailed => 'Error al recortar el vídeo 2';

  @override
  String get mergeSuccess => '¡Fusión exitosa!';

  @override
  String get mergeFailed => 'Fusión fallida';

  @override
  String mergeError(String error) {
    return 'Error de fusión: $error';
  }

  @override
  String get merging => 'Fusionando...';

  @override
  String get startMerge => 'Iniciar fusión';

  @override
  String get compressVideo => 'Comprimir vídeo';

  @override
  String get compressSuccess => '¡Compresión completada!';

  @override
  String get compressFailed => 'Compresión fallida';

  @override
  String compressError(String error) {
    return 'Error de compresión: $error';
  }

  @override
  String originalSize(String size) {
    return 'Tamaño original: $size';
  }

  @override
  String compressQuality(int value) {
    return 'Calidad de compresión (CRF): $value';
  }

  @override
  String get compressTip =>
      'Un valor más alto significa más compresión y menor calidad';

  @override
  String get encodeSpeed => 'Velocidad de codificación:';

  @override
  String compressedSize(String size) {
    return 'Comprimido: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Ahorrado: $size ($percent%)';
  }

  @override
  String get compressing => 'Comprimiendo...';

  @override
  String get startCompress => 'Iniciar compresión';

  @override
  String get convertFormat => 'Convertir formato';

  @override
  String get convertSuccess => '¡Conversión exitosa!';

  @override
  String get convertFailed => 'Conversión fallida';

  @override
  String convertError(String error) {
    return 'Error de conversión: $error';
  }

  @override
  String get targetFormat => 'Formato de destino:';

  @override
  String get converting => 'Convirtiendo...';

  @override
  String convertTo(String format) {
    return 'Convertir a $format';
  }

  @override
  String get cropVideo => 'Recortar vídeo';

  @override
  String get cropSuccess => '¡Recorte exitoso!';

  @override
  String get cropFailed => 'Recorte fallido';

  @override
  String cropError(String error) {
    return 'Error de recorte: $error';
  }

  @override
  String get cropPreviewFailedButSaved =>
      'Error en la vista previa, pero el archivo se ha generado';

  @override
  String originalResolution(int width, int height) {
    return 'Original: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Recorte: ${width}x$height';
  }

  @override
  String get cropDragTip =>
      'Arrastra el cuadro verde o los bordes para ajustar el área de recorte, arrastra dentro para mover';

  @override
  String get resetCrop => 'Restablecer área de recorte';

  @override
  String get cropping => 'Recortando...';

  @override
  String get startCrop => 'Iniciar recorte';

  @override
  String get cutVideo => 'Cortar vídeo';

  @override
  String get cutSuccess => '¡Corte exitoso!';

  @override
  String get cutFailed => 'Corte fallido';

  @override
  String cutError(String error) {
    return 'Error de corte: $error';
  }

  @override
  String get cutCompletePreviewUnavailable =>
      'Corte completado (vista previa no disponible)';

  @override
  String get videoPreviewUnavailable => 'Vista previa del vídeo no disponible';

  @override
  String totalDuration(String duration) {
    return 'Duración total: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'Corte: $start - $end  ($duration)';
  }

  @override
  String get cutting => 'Cortando...';

  @override
  String get startCut => 'Iniciar corte';

  @override
  String get dubbingVideo => 'Doblar vídeo';

  @override
  String get dubbingSuccess => '¡Doblaje exitoso!';

  @override
  String get dubbingFailed => 'Doblaje fallido';

  @override
  String dubbingError(String error) {
    return 'Error de doblaje: $error';
  }

  @override
  String get selectVideo => 'Seleccionar vídeo';

  @override
  String get videoSelected => 'Vídeo seleccionado';

  @override
  String get selectAudio => 'Seleccionar audio';

  @override
  String get audioSelected => 'Audio seleccionado';

  @override
  String get dubbingMode => 'Modo de doblaje:';

  @override
  String get replaceOriginalAudio => 'Reemplazar audio original';

  @override
  String get replaceAudioHint => 'Desactiva para mezclar ambas pistas de audio';

  @override
  String get dubbing => 'Doblando...';

  @override
  String get startDubbing => 'Iniciar doblaje';

  @override
  String get startOver => 'Empezar de nuevo';

  @override
  String get extractImages => 'Extraer imágenes';

  @override
  String get startTimeMustBeBeforeEnd =>
      'El tiempo de inicio debe ser anterior al tiempo de fin';

  @override
  String extractedCount(int count) {
    return 'Se extrajeron $count imágenes';
  }

  @override
  String get noImagesExtracted =>
      'No se extrajeron imágenes, verifica el archivo de vídeo';

  @override
  String get extractFailed => 'Extracción fallida';

  @override
  String extractError(String error) {
    return 'Error de extracción: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return 'Se guardaron $count imágenes en el álbum';
  }

  @override
  String videoDuration(String duration) {
    return 'Duración del vídeo: $duration';
  }

  @override
  String get startTime => 'Tiempo de inicio';

  @override
  String get endTime => 'Tiempo de fin';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Rango de extracción: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Tasa de extracción: $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return 'Se extraerán aproximadamente $count imágenes';
  }

  @override
  String get extracting => 'Extrayendo...';

  @override
  String get startExtract => 'Iniciar extracción';

  @override
  String extractedImagesCount(int count) {
    return 'Se extrajeron $count imágenes';
  }

  @override
  String showingFirst30(int count) {
    return 'Mostrando las primeras 30 de $count';
  }

  @override
  String saveAllCount(int count) {
    return 'Guardar todas ($count)';
  }

  @override
  String get muteVideo => 'Silenciar vídeo';

  @override
  String get muteSuccess => '¡Silencio exitoso!';

  @override
  String get muteFailed => 'Silencio fallido';

  @override
  String muteError(String error) {
    return 'Error de silencio: $error';
  }

  @override
  String get muteDescription =>
      'Se eliminará todo el audio, solo se conservarán los fotogramas del vídeo';

  @override
  String get muting => 'Silenciando...';

  @override
  String get removeAudio => 'Eliminar audio';

  @override
  String get ratioVideo => 'Relación de aspecto';

  @override
  String get ratioSuccess => '¡Relación ajustada exitosamente!';

  @override
  String get ratioFailed => 'Error al ajustar la relación';

  @override
  String ratioError(String error) {
    return 'Error de relación: $error';
  }

  @override
  String get targetRatio => 'Relación objetivo:';

  @override
  String get scaleMode => 'Modo de escala:';

  @override
  String get stretchFit => 'Estirar para ajustar';

  @override
  String get cropFill => 'Recortar y rellenar';

  @override
  String get letterbox => 'Barras negras';

  @override
  String get adjusting => 'Ajustando...';

  @override
  String get startAdjust => 'Iniciar ajuste';

  @override
  String get separateAV => 'Separar A/V';

  @override
  String get separateComplete => '¡Separación completada!';

  @override
  String get separateFailed =>
      'Separación fallida, el vídeo puede no contener pistas de audio/vídeo';

  @override
  String separateError(String error) {
    return 'Error de separación: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Solo vídeo guardado en el álbum';

  @override
  String get saveVideoFailed => 'Error al guardar el vídeo';

  @override
  String saveVideoError(String error) {
    return 'Error al guardar el vídeo: $error';
  }

  @override
  String get cannotGetDownloadDir =>
      'No se puede obtener el directorio de descargas';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label guardado en: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return 'El archivo $label no existe';
  }

  @override
  String get separateDescription =>
      'Extraer los fotogramas y el audio del vídeo como archivos independientes';

  @override
  String get separating => 'Separando...';

  @override
  String get startSeparate => 'Iniciar separación';

  @override
  String get videoOnly => 'Solo vídeo (sin audio)';

  @override
  String get savedToAlbumLabel => 'Guardado en el álbum';

  @override
  String get m4aAudio => 'Audio M4A';

  @override
  String get mp3Audio => 'Audio MP3';

  @override
  String get savedToDownloadsShort => 'Guardado en Downloads';

  @override
  String get playMp3Audio => 'Reproducir audio MP3';

  @override
  String get playM4aAudio => 'Reproducir audio M4A';

  @override
  String get splitVideo => 'Dividir vídeo';

  @override
  String get addAtLeastOneSplitPoint =>
      'Por favor, añade al menos un punto de división';

  @override
  String splitComplete(int count) {
    return '¡División completada! $count segmentos';
  }

  @override
  String get splitFailed => 'División fallida';

  @override
  String splitError(String error) {
    return 'Error de división: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return 'Se guardaron $count segmentos en el álbum';
  }

  @override
  String get splitPoints => 'Puntos de división:';

  @override
  String get add => 'Añadir';

  @override
  String get noSplitPoints => 'Sin puntos de división, toca para añadir';

  @override
  String splitPoint(int index) {
    return 'Punto de división $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'Se producirán $count segmentos después de la división:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Segmento $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'Dividiendo...';

  @override
  String get startSplit => 'Iniciar división';

  @override
  String saveAllSegments(int count) {
    return 'Guardar todos los $count segmentos';
  }

  @override
  String segment(int index) {
    return 'Segmento $index';
  }

  @override
  String get privacyTitle => 'Política de privacidad';

  @override
  String get updateDate => 'Fecha de actualización';

  @override
  String get privacyDate => '1 de enero de 2025';

  @override
  String get section1Title => '1. Recopilación de información';

  @override
  String get section1Content =>
      'Tomamos su privacidad muy en serio. Esta aplicación solo recopila la siguiente información necesaria durante la prestación del servicio:';

  @override
  String get section1Item1 =>
      'Archivos de vídeo/audio que usted selecciona activamente (solo se usan para procesamiento local, nunca se suben a ningún servidor)';

  @override
  String get section1Item2 =>
      'Información básica del dispositivo (para adaptación del dispositivo, no contiene información de identidad personal)';

  @override
  String get section2Title => '2. Uso de la información';

  @override
  String get section2Content =>
      'Todo el procesamiento de audio/vídeo se completa localmente en su dispositivo. Nunca subiremos sus archivos o datos a servidores remotos. La información del dispositivo recopilada solo se usa para adaptación de funciones e investigación de fallos.';

  @override
  String get section3Title => '3. Almacenamiento de información';

  @override
  String get section3Content =>
      'Los archivos temporales generados por la aplicación se almacenan en el directorio temporal local del dispositivo. Puede guardarlos o eliminarlos a su discreción después del procesamiento. No almacenamos ninguno de sus datos en servidores.';

  @override
  String get section4Title => '4. Compartir información';

  @override
  String get section4Content =>
      'No venderemos, intercambiaremos ni transferiremos su información personal a terceros, excepto en los siguientes casos:';

  @override
  String get section4Item1 => 'Con su consentimiento explícito';

  @override
  String get section4Item2 =>
      'Según lo requiera la ley o una orden gubernamental';

  @override
  String get section5Title => '5. Servicios de terceros';

  @override
  String get section5Content =>
      'Esta aplicación utiliza algunos SDK de terceros para proporcionar servicios, que pueden tener sus propias políticas de privacidad. Consulte la página \"Lista de SDK de terceros\" para más detalles.';

  @override
  String get section6Title => '6. Seguridad de datos';

  @override
  String get section6Content =>
      'Tomamos medidas de seguridad razonables para proteger su información contra acceso, uso o divulgación no autorizados. Sin embargo, tenga en cuenta que Internet no es absolutamente seguro. Le recomendamos mantener su dispositivo seguro.';

  @override
  String get section7Title => '7. Protección de menores';

  @override
  String get section7Content =>
      'Otorgamos gran importancia a la protección de la información personal de menores. Si es menor de 18 años, le recomendamos usar esta aplicación bajo la supervisión de un tutor.';

  @override
  String get section8Title => '8. Cambios en la política de privacidad';

  @override
  String get section8Content =>
      'Podemos revisar esta política de privacidad de vez en cuando. Cuando se produzcan cambios, se lo notificaremos mediante ventanas emergentes o anuncios en la aplicación.';

  @override
  String get section9Title => '9. Contáctenos';

  @override
  String get section9Content =>
      'Si tiene preguntas o sugerencias sobre esta política de privacidad, contáctenos en:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc =>
      'Framework de desarrollo de aplicaciones multiplataforma para construir UI e interacciones';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc =>
      'Biblioteca principal de procesamiento de audio/vídeo para recorte, compresión y conversión de formato de vídeo';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc =>
      'Componente de reproducción de vídeo para vista previa de vídeos';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc =>
      'Selector de archivos para elegir archivos locales de vídeo y audio';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc =>
      'Herramienta de guardado en álbum para guardar archivos procesados en el álbum del sistema';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc =>
      'Componente de gestión de permisos para solicitar permisos de almacenamiento, álbum, etc.';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc =>
      'Proveedor de rutas para obtener directorios temporales y de documentos';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc =>
      'Biblioteca de gestión de estado para compartir y gestionar el estado dentro de la aplicación';

  @override
  String licenseLabel(String license) {
    return 'Licencia: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Error al inicializar el vídeo: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Error al seleccionar vídeo: $error';
  }
}
