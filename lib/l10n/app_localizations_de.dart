import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => 'Alle';

  @override
  String get tabSettings => 'Einstellungen';

  @override
  String get settingsAbout => 'Einstellungen & Über';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get autoMode => 'Auto (17 Uhr)';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get appNameLabel => 'App-Name';

  @override
  String get versionLabel => 'Version';

  @override
  String get developerLabel => 'Entwickler';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get viewPrivacyTerms => 'Datenschutzbestimmungen anzeigen';

  @override
  String get sdkList => 'Drittanbieter-SDK-Liste';

  @override
  String get viewThirdPartyServices => 'Drittanbieter-Dienste anzeigen';

  @override
  String get iapDescription => 'In-App-Kauf';

  @override
  String get viewIapDetails => 'In-App-Kauf- und Abonnementdetails anzeigen';

  @override
  String get iapSection1Title => '1. In-App-Kauf-Artikel';

  @override
  String get iapSection1Content => 'Diese App bietet einen „Premium\"-In-App-Kauf an, der ein Einmalkauf ist, kein automatisch verlängerbares Abonnement. Nach dem Kauf schalten Sie dauerhaft alle Funktionen frei, einschließlich: unbegrenztes Speichern im Album, uneingeschränkte Nutzung aller Tools, kostenlose zukünftige Updates und werbefreie Erfahrung.';

  @override
  String get iapSection2Title => '2. Zahlung & Bestätigung';

  @override
  String get iapSection2Content => 'Der Kauf wird von Ihrer Apple-ID / Ihrem Google Play-Konto abgebucht. Nach Bestätigung wird der Betrag von Ihrem Konto abgezogen.';

  @override
  String get iapSection3Title => '3. Käufe wiederherstellen';

  @override
  String get iapSection3Content => 'Wenn Sie das Gerät wechseln oder die App neu installieren, können Sie auf der Einstellungs- oder Shop-Seite „Käufe wiederherstellen\" antippen, um Ihren Premium-Zugang kostenlos wiederherzustellen, ohne erneut zu bezahlen.';

  @override
  String get iapSection4Title => '4. Stornierung & Erstattung';

  @override
  String get iapSection4Content => 'Dies ist ein Einmalkauf. Erstattungen werden nach dem Kauf nicht unterstützt. Wenn Sie eine Erstattung benötigen, beantragen Sie diese über die offiziellen Apple-/Google Play-Kanäle.';

  @override
  String get iapSection5Title => '5. Kontaktieren Sie uns';

  @override
  String get iapSection5Content => 'Wenn Sie Fragen zu In-App-Käufen haben, kontaktieren Sie bitte:\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => 'Willkommen bei ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return 'Sie haben $count kostenlose Nutzungen. Jedes Speichern im Album verbraucht 1 Nutzung.';
  }

  @override
  String get welcomeUpgradeHint => 'Upgraden Sie auf Premium für unbegrenzten Zugriff auf alle Funktionen';

  @override
  String get welcomeGotIt => 'Verstanden';

  @override
  String get welcomeUpgrade => 'Auf Premium upgraden';

  @override
  String freeCountRemaining(int count) {
    return '$count verbleibend';
  }

  @override
  String get freeCountExhausted => 'Kostenlose Nutzungen aufgebraucht';

  @override
  String get upgradeToUnlock => 'Upgraden Sie auf Premium für unbegrenzte Nutzung';

  @override
  String get openSourceNotice => 'Erstellt mit FFmpeg, Flutter und anderen Open-Source-Technologien. Dank an die Open-Source-Community.';

  @override
  String get harmonyDeveloping => 'HarmonyOS-Version ist in Entwicklung';

  @override
  String get language => 'Sprache';

  @override
  String get toolMerge => 'Videos zusammenführen';

  @override
  String get toolMergeDesc => 'Mehrere Videodateien zu einer zusammenführen';

  @override
  String get toolCut => 'Video schneiden';

  @override
  String get toolCutDesc => 'Einen bestimmten Zeitabschnitt aus dem Video extrahieren';

  @override
  String get toolCompress => 'Video komprimieren';

  @override
  String get toolCompressDesc => 'Videodateigröße reduzieren';

  @override
  String get toolRatio => 'Video-Seitenverhältnis';

  @override
  String get toolRatioDesc => 'Seitenverhältnis anpassen';

  @override
  String get toolMute => 'Video stumm schalten';

  @override
  String get toolMuteDesc => 'Audiospur aus dem Video entfernen';

  @override
  String get toolDubbing => 'Video vertonen';

  @override
  String get toolDubbingDesc => 'Hintergrundmusik zum Video hinzufügen';

  @override
  String get toolExtract => 'Bilder extrahieren';

  @override
  String get toolExtractDesc => 'Einzelbilder aus dem Video extrahieren';

  @override
  String get toolSplit => 'Video aufteilen';

  @override
  String get toolSplitDesc => 'Video in mehrere Segmente aufteilen';

  @override
  String get toolSeparate => 'A/V trennen';

  @override
  String get toolSeparateDesc => 'Audio- und Videospuren trennen';

  @override
  String get toolCrop => 'Video zuschneiden';

  @override
  String get toolCropDesc => 'Videobildbereich zuschneiden';

  @override
  String get toolConvert => 'Format konvertieren';

  @override
  String get toolConvertDesc => 'Videodateiformat konvertieren';

  @override
  String toolCountAll(int count) {
    return '$count Tools · Alle';
  }

  @override
  String featureDeveloping(String name) {
    return '$name ist in Entwicklung';
  }

  @override
  String get selectVideoFailed => 'Videoauswahl fehlgeschlagen';

  @override
  String get selectAudioFailed => 'Audioauswahl fehlgeschlagen';

  @override
  String get needAlbumPermission => 'Album-Berechtigung erforderlich';

  @override
  String get savedToAlbum => 'Im Album gespeichert';

  @override
  String get saveFailed => 'Speichern fehlgeschlagen';

  @override
  String saveError(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get loading => 'Laden...';

  @override
  String get tapToSelectVideo => 'Tippen, um ein Video auszuwählen';

  @override
  String get tapToSelectFirstVideo => 'Erstes Video auswählen';

  @override
  String get tapToSelectSecondVideo => 'Zweites Video auswählen';

  @override
  String get tapToPreview => 'Tippen für Vorschau';

  @override
  String get start => 'Start';

  @override
  String get end => 'Ende';

  @override
  String get change => 'Ändern';

  @override
  String get reselect => 'Neu auswählen';

  @override
  String get changeVideo => 'Video ändern';

  @override
  String get saveToAlbum => 'Im Album speichern';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String get videoLoadFailed => 'Videoladen fehlgeschlagen';

  @override
  String get previewFailed => 'Vorschau fehlgeschlagen';

  @override
  String get previewInitFailed => 'Vorschau-Initialisierung fehlgeschlagen';

  @override
  String get mergeVideo => 'Videos zusammenführen';

  @override
  String get selectTwoVideosToMerge => 'Zwei Videos zum Zusammenführen auswählen';

  @override
  String get video1 => 'Video 1';

  @override
  String get video2 => 'Video 2';

  @override
  String get selectVideo1 => 'Video 1 auswählen';

  @override
  String get selectVideo2 => 'Video 2 auswählen';

  @override
  String get pleaseSelectTwoVideos => 'Bitte zuerst zwei Videos auswählen';

  @override
  String get webNotSupportMerge => 'Zusammenführen wird im Web nicht unterstützt';

  @override
  String get video1CropFailed => 'Zuschneiden von Video 1 fehlgeschlagen';

  @override
  String get video2CropFailed => 'Zuschneiden von Video 2 fehlgeschlagen';

  @override
  String get mergeSuccess => 'Zusammenführung erfolgreich!';

  @override
  String get mergeFailed => 'Zusammenführung fehlgeschlagen';

  @override
  String mergeError(String error) {
    return 'Fehler beim Zusammenführen: $error';
  }

  @override
  String get merging => 'Zusammenführung...';

  @override
  String get startMerge => 'Zusammenführung starten';

  @override
  String get compressVideo => 'Video komprimieren';

  @override
  String get compressSuccess => 'Komprimierung abgeschlossen!';

  @override
  String get compressFailed => 'Komprimierung fehlgeschlagen';

  @override
  String compressError(String error) {
    return 'Komprimierungsfehler: $error';
  }

  @override
  String originalSize(String size) {
    return 'Originalgröße: $size';
  }

  @override
  String compressQuality(int value) {
    return 'Komprimierungsqualität (CRF): $value';
  }

  @override
  String get compressTip => 'Höherer Wert bedeutet stärkere Komprimierung, geringere Qualität';

  @override
  String get encodeSpeed => 'Kodierungsgeschwindigkeit:';

  @override
  String compressedSize(String size) {
    return 'Komprimiert: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Gespart: $size ($percent%)';
  }

  @override
  String get compressing => 'Komprimierung...';

  @override
  String get startCompress => 'Komprimierung starten';

  @override
  String get convertFormat => 'Format konvertieren';

  @override
  String get convertSuccess => 'Konvertierung erfolgreich!';

  @override
  String get convertFailed => 'Konvertierung fehlgeschlagen';

  @override
  String convertError(String error) {
    return 'Konvertierungsfehler: $error';
  }

  @override
  String get targetFormat => 'Zielformat:';

  @override
  String get converting => 'Konvertierung...';

  @override
  String convertTo(String format) {
    return 'Konvertieren zu $format';
  }

  @override
  String get cropVideo => 'Video zuschneiden';

  @override
  String get cropSuccess => 'Zuschnitt erfolgreich!';

  @override
  String get cropFailed => 'Zuschnitt fehlgeschlagen';

  @override
  String cropError(String error) {
    return 'Zuschnittsfehler: $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'Vorschau fehlgeschlagen, aber Datei wurde erstellt';

  @override
  String originalResolution(int width, int height) {
    return 'Original: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Zuschnitt: ${width}x$height';
  }

  @override
  String get cropDragTip => 'Ziehen Sie den grünen Rahmen oder die Ränder, um den Zuschnittbereich anzupassen, ziehen Sie im Inneren zum Verschieben';

  @override
  String get resetCrop => 'Zuschnittbereich zurücksetzen';

  @override
  String get cropping => 'Zuschneiden...';

  @override
  String get startCrop => 'Zuschnitt starten';

  @override
  String get cutVideo => 'Video schneiden';

  @override
  String get cutSuccess => 'Schnitt erfolgreich!';

  @override
  String get cutFailed => 'Schnitt fehlgeschlagen';

  @override
  String cutError(String error) {
    return 'Schnittfehler: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => 'Schnitt abgeschlossen (Vorschau nicht verfügbar)';

  @override
  String get videoPreviewUnavailable => 'Videovorschau nicht verfügbar';

  @override
  String totalDuration(String duration) {
    return 'Gesamtdauer: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'Schnitt: $start - $end  ($duration)';
  }

  @override
  String get cutting => 'Schneiden...';

  @override
  String get startCut => 'Schnitt starten';

  @override
  String get dubbingVideo => 'Video vertonen';

  @override
  String get dubbingSuccess => 'Vertonung erfolgreich!';

  @override
  String get dubbingFailed => 'Vertonung fehlgeschlagen';

  @override
  String dubbingError(String error) {
    return 'Vertonungsfehler: $error';
  }

  @override
  String get selectVideo => 'Video auswählen';

  @override
  String get videoSelected => 'Video ausgewählt';

  @override
  String get selectAudio => 'Audio auswählen';

  @override
  String get audioSelected => 'Audio ausgewählt';

  @override
  String get dubbingMode => 'Vertonungsmodus:';

  @override
  String get replaceOriginalAudio => 'Originalton ersetzen';

  @override
  String get replaceAudioHint => 'Deaktivieren, um beide Audiospuren zu mischen';

  @override
  String get dubbing => 'Vertonung...';

  @override
  String get startDubbing => 'Vertonung starten';

  @override
  String get startOver => 'Neu beginnen';

  @override
  String get extractImages => 'Bilder extrahieren';

  @override
  String get startTimeMustBeBeforeEnd => 'Startzeit muss vor Endzeit liegen';

  @override
  String extractedCount(int count) {
    return '$count Bilder extrahiert';
  }

  @override
  String get noImagesExtracted => 'Keine Bilder extrahiert, bitte Videodatei überprüfen';

  @override
  String get extractFailed => 'Extraktion fehlgeschlagen';

  @override
  String extractError(String error) {
    return 'Extraktionsfehler: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return '$count Bilder im Album gespeichert';
  }

  @override
  String videoDuration(String duration) {
    return 'Videodauer: $duration';
  }

  @override
  String get startTime => 'Startzeit';

  @override
  String get endTime => 'Endzeit';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Extraktionsbereich: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Extraktionsrate: $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return 'Etwa $count Bilder werden extrahiert';
  }

  @override
  String get extracting => 'Extrahieren...';

  @override
  String get startExtract => 'Extraktion starten';

  @override
  String extractedImagesCount(int count) {
    return '$count Bilder extrahiert';
  }

  @override
  String showingFirst30(int count) {
    return 'Zeige erste 30 von $count';
  }

  @override
  String saveAllCount(int count) {
    return 'Alle $count speichern';
  }

  @override
  String get muteVideo => 'Video stumm schalten';

  @override
  String get muteSuccess => 'Stumm geschaltet!';

  @override
  String get muteFailed => 'Stumm schalten fehlgeschlagen';

  @override
  String muteError(String error) {
    return 'Fehler beim Stumm schalten: $error';
  }

  @override
  String get muteDescription => 'Alle Audiospuren werden entfernt, nur Videobilder bleiben erhalten';

  @override
  String get muting => 'Stumm schalten...';

  @override
  String get removeAudio => 'Audio entfernen';

  @override
  String get ratioVideo => 'Video-Seitenverhältnis';

  @override
  String get ratioSuccess => 'Seitenverhältnis erfolgreich angepasst!';

  @override
  String get ratioFailed => 'Anpassung des Seitenverhältnisses fehlgeschlagen';

  @override
  String ratioError(String error) {
    return 'Seitenverhältnisfehler: $error';
  }

  @override
  String get targetRatio => 'Zielverhältnis:';

  @override
  String get scaleMode => 'Skalierungsmodus:';

  @override
  String get stretchFit => 'Strecken';

  @override
  String get cropFill => 'Zuschnitt-Füllung';

  @override
  String get letterbox => 'Briefkasten';

  @override
  String get adjusting => 'Anpassung...';

  @override
  String get startAdjust => 'Anpassung starten';

  @override
  String get separateAV => 'A/V trennen';

  @override
  String get separateComplete => 'Trennung abgeschlossen!';

  @override
  String get separateFailed => 'Trennung fehlgeschlagen, Video enthält möglicherweise keine Audio-/Videospuren';

  @override
  String separateError(String error) {
    return 'Trennungsfehler: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Nur Video im Album gespeichert';

  @override
  String get saveVideoFailed => 'Videospeichern fehlgeschlagen';

  @override
  String saveVideoError(String error) {
    return 'Videospeicherfehler: $error';
  }

  @override
  String get cannotGetDownloadDir => 'Download-Verzeichnis kann nicht abgerufen werden';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label gespeichert in: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return '$label-Datei existiert nicht';
  }

  @override
  String get separateDescription => 'Videobilder und Audio als separate Dateien extrahieren';

  @override
  String get separating => 'Trennung...';

  @override
  String get startSeparate => 'Trennung starten';

  @override
  String get videoOnly => 'Nur Video (kein Audio)';

  @override
  String get savedToAlbumLabel => 'Im Album gespeichert';

  @override
  String get m4aAudio => 'M4A-Audio';

  @override
  String get mp3Audio => 'MP3-Audio';

  @override
  String get savedToDownloadsShort => 'Im Download gespeichert';

  @override
  String get playMp3Audio => 'MP3-Audio abspielen';

  @override
  String get playM4aAudio => 'M4A-Audio abspielen';

  @override
  String get splitVideo => 'Video aufteilen';

  @override
  String get addAtLeastOneSplitPoint => 'Bitte mindestens einen Aufteilungspunkt hinzufügen';

  @override
  String splitComplete(int count) {
    return 'Aufteilung abgeschlossen! $count Segmente';
  }

  @override
  String get splitFailed => 'Aufteilung fehlgeschlagen';

  @override
  String splitError(String error) {
    return 'Aufteilungsfehler: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return '$count Segmente im Album gespeichert';
  }

  @override
  String get splitPoints => 'Aufteilungspunkte:';

  @override
  String get add => 'Hinzufügen';

  @override
  String get noSplitPoints => 'Keine Aufteilungspunkte, tippen zum Hinzufügen';

  @override
  String splitPoint(int index) {
    return 'Aufteilungspunkt $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'Ergibt $count Segmente nach der Aufteilung:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Segment $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'Aufteilung...';

  @override
  String get startSplit => 'Aufteilung starten';

  @override
  String saveAllSegments(int count) {
    return 'Alle $count Segmente speichern';
  }

  @override
  String segment(int index) {
    return 'Segment $index';
  }

  @override
  String get privacyTitle => 'Datenschutzrichtlinie';

  @override
  String get updateDate => 'Aktualisierungsdatum';

  @override
  String get privacyDate => '1. Januar 2025';

  @override
  String get section1Title => '1. Informationserhebung';

  @override
  String get section1Content => 'Wir nehmen Ihre Privatsphäre sehr ernst. Diese App erhebt nur die folgenden notwendigen Informationen bei der Dienstleistungserbringung:';

  @override
  String get section1Item1 => 'Video-/Audiodateien, die Sie aktiv auswählen (nur zur lokalen Verarbeitung, werden nie auf einen Server hochgeladen)';

  @override
  String get section1Item2 => 'Grundlegende Geräteinformationen (zur Geräteanpassung, enthalten keine persönlichen Identitätsinformationen)';

  @override
  String get section2Title => '2. Informationsverwendung';

  @override
  String get section2Content => 'Die gesamte Audio-/Videoverarbeitung erfolgt lokal auf Ihrem Gerät. Wir werden niemals Ihre Dateien oder Daten auf Remote-Server hochladen. Gesammelte Geräteinformationen werden nur zur Funktionsanpassung und Absturzuntersuchung verwendet.';

  @override
  String get section3Title => '3. Informationsspeicherung';

  @override
  String get section3Content => 'Temporäre Dateien der App werden im lokalen temporären Verzeichnis des Geräts gespeichert. Sie können diese nach der Verarbeitung nach Belieben speichern oder löschen. Wir speichern keine Ihrer Daten auf Servern.';

  @override
  String get section4Title => '4. Informationsaustausch';

  @override
  String get section4Content => 'Wir werden Ihre persönlichen Informationen nicht an Dritte verkaufen, tauschen oder anderweitig übertragen, außer in folgenden Fällen:';

  @override
  String get section4Item1 => 'Mit Ihrer ausdrücklichen Zustimmung';

  @override
  String get section4Item2 => 'Gemäß Gesetz oder behördlicher Anordnung';

  @override
  String get section5Title => '5. Drittanbieter-Dienste';

  @override
  String get section5Content => 'Diese App verwendet einige Drittanbieter-SDKs zur Diensterbringung, die eigene Datenschutzrichtlinien haben können. Einzelheiten siehe „Drittanbieter-SDK-Liste\".';

  @override
  String get section6Title => '6. Datensicherheit';

  @override
  String get section6Content => 'Wir ergreifen angemessene Sicherheitsmaßnahmen, um Ihre Informationen vor unbefugtem Zugriff, Nutzung oder Offenlegung zu schützen. Bitte beachten Sie jedoch, dass das Internet nicht absolut sicher ist. Wir empfehlen, Ihr Gerät sicher zu halten.';

  @override
  String get section7Title => '7. Schutz Minderjähriger';

  @override
  String get section7Content => 'Wir legen großen Wert auf den Schutz persönlicher Informationen von Minderjährigen. Wenn Sie unter 18 Jahre alt sind, empfehlen wir die Nutzung dieser App unter Anleitung eines Erziehungsberechtigten.';

  @override
  String get section8Title => '8. Änderungen der Datenschutzrichtlinie';

  @override
  String get section8Content => 'Wir können diese Datenschutzrichtlinie von Zeit zu Zeit überarbeiten. Bei Änderungen werden wir Sie über In-App-Pop-ups oder Ankündigungen informieren.';

  @override
  String get section9Title => '9. Kontaktieren Sie uns';

  @override
  String get section9Content => 'Wenn Sie Fragen oder Vorschläge zu dieser Datenschutzrichtlinie haben, kontaktieren Sie uns unter:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'Plattformübergreifendes Anwendungsentwicklungsframework für UI und Interaktionen';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => 'Kernbibliothek für Audio-/Videoverarbeitung für Videoschnitt, Komprimierung, Formatkonvertierung usw.';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => 'Videowiedergabekomponente für Videovorschau';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc => 'Dateiauswahl zum Auswählen lokaler Video- und Audiodateien';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc => 'Album-Speichertool zum Speichern verarbeiteter Dateien im Systemalbum';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc => 'Berechtigungsverwaltungskomponente für Speicher-, Album- und andere Systemberechtigungen';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc => 'Pfadanbieter zum Abrufen temporärer und Dokumentverzeichnisse';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'Zustandsverwaltungsbibliothek für In-App-Zustandsfreigabe und -verwaltung';

  @override
  String licenseLabel(String license) {
    return 'Lizenz: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Video-Initialisierung fehlgeschlagen: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Videoauswahl fehlgeschlagen: $error';
  }

  @override
  String get premiumVersion => 'Premium';

  @override
  String get alreadyPremium => 'Sie sind bereits Premium-Nutzer!';

  @override
  String get alreadyPremiumDesc => 'Danke für Ihre Unterstützung, alle Funktionen sind freigeschaltet';

  @override
  String get unlockPremium => 'Premium freischalten';

  @override
  String get unlockPremiumDesc => 'Einmalkauf, dauerhafter Zugriff auf alle Funktionen';

  @override
  String get featureUnlimitedSave => 'Unbegrenztes Speichern im Album';

  @override
  String get featureUnlimitedTools => 'Uneingeschränkte Nutzung aller Tools';

  @override
  String get featureFreeUpdates => 'Kostenlose zukünftige Updates';

  @override
  String get featureNoAds => 'Werbefreie Erfahrung';

  @override
  String get unlockNow => 'Jetzt freischalten';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get video1LoadFailed => 'Laden von Video 1 fehlgeschlagen';

  @override
  String get video2LoadFailed => 'Laden von Video 2 fehlgeschlagen';

  @override
  String get selectVideoLabel => 'Video auswählen';

  @override
  String get videoChanged => 'Video ändern';

  @override
  String get saveVideoOnly => 'Nur Video speichern';

  @override
  String get videoOnlySaved => 'Nur Video gespeichert';

  @override
  String get sourceFileNotExist => 'Quelldatei existiert nicht';

  @override
  String saveLabel(String label) {
    return '$label speichern';
  }

  @override
  String labelSaved(String label) {
    return '$label gespeichert';
  }

  @override
  String saveLabelError(String error) {
    return 'Speicherfehler: $error';
  }

  @override
  String get noImagesExtractedShort => 'Keine Bilder extrahiert';

  @override
  String get reMerge => 'Erneut zusammenführen';

  @override
  String get originalLabel => 'Original:';

  @override
  String get segmentCount => 'Segmente';
}
