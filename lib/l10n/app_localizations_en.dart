// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Video ToolKit';

  @override
  String get tabAll => 'All';

  @override
  String get tabSettings => 'Settings';

  @override
  String get settingsAbout => 'Settings & About';

  @override
  String get appearance => 'Appearance';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get aboutApp => 'About App';

  @override
  String get appNameLabel => 'App Name';

  @override
  String get versionLabel => 'Version';

  @override
  String get developerLabel => 'Developer';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get viewPrivacyTerms => 'View privacy terms';

  @override
  String get sdkList => 'Third-party SDK List';

  @override
  String get viewThirdPartyServices => 'View third-party services';

  @override
  String get openSourceNotice =>
      'Built with FFmpeg, Flutter and other open-source technologies. Thanks to the open-source community.';

  @override
  String get harmonyDeveloping => 'HarmonyOS version is under development';

  @override
  String get language => 'Language';

  @override
  String get toolMerge => 'Merge Videos';

  @override
  String get toolMergeDesc => 'Merge multiple video files into one';

  @override
  String get toolCut => 'Cut Video';

  @override
  String get toolCutDesc => 'Extract a specific time segment from video';

  @override
  String get toolCompress => 'Compress Video';

  @override
  String get toolCompressDesc => 'Reduce video file size';

  @override
  String get toolRatio => 'Video Ratio';

  @override
  String get toolRatioDesc => 'Adjust aspect ratio';

  @override
  String get toolMute => 'Mute Video';

  @override
  String get toolMuteDesc => 'Remove audio track from video';

  @override
  String get toolDubbing => 'Dub Video';

  @override
  String get toolDubbingDesc => 'Add background music to video';

  @override
  String get toolExtract => 'Extract Images';

  @override
  String get toolExtractDesc => 'Extract frames from video as images';

  @override
  String get toolSplit => 'Split Video';

  @override
  String get toolSplitDesc => 'Split video into multiple segments';

  @override
  String get toolSeparate => 'Separate A/V';

  @override
  String get toolSeparateDesc => 'Separate audio and video tracks';

  @override
  String get toolCrop => 'Crop Video';

  @override
  String get toolCropDesc => 'Crop video frame area';

  @override
  String get toolConvert => 'Convert Format';

  @override
  String get toolConvertDesc => 'Convert video file format';

  @override
  String toolCountAll(int count) {
    return '$count tools · All';
  }

  @override
  String featureDeveloping(String name) {
    return '$name is under development';
  }

  @override
  String get selectVideoFailed => 'Failed to select video';

  @override
  String get selectAudioFailed => 'Failed to select audio';

  @override
  String get needAlbumPermission => 'Album permission required';

  @override
  String get savedToAlbum => 'Saved to album';

  @override
  String get saveFailed => 'Save failed';

  @override
  String saveError(String error) {
    return 'Save error: $error';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get tapToSelectVideo => 'Tap to select a video';

  @override
  String get tapToSelectFirstVideo => 'Tap to select the first video';

  @override
  String get tapToSelectSecondVideo => 'Tap to select the second video';

  @override
  String get tapToPreview => 'Tap to preview';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get change => 'Change';

  @override
  String get reselect => 'Reselect';

  @override
  String get changeVideo => 'Change Video';

  @override
  String get saveToAlbum => 'Save to Album';

  @override
  String get processing => 'Processing...';

  @override
  String get videoLoadFailed => 'Video load failed';

  @override
  String get previewFailed => 'Preview failed';

  @override
  String get previewInitFailed => 'Preview initialization failed';

  @override
  String get mergeVideo => 'Merge Videos';

  @override
  String get selectTwoVideosToMerge => 'Select two videos to merge';

  @override
  String get video1 => 'Video 1';

  @override
  String get video2 => 'Video 2';

  @override
  String get selectVideo1 => 'Select Video 1';

  @override
  String get selectVideo2 => 'Select Video 2';

  @override
  String get pleaseSelectTwoVideos => 'Please select two videos first';

  @override
  String get webNotSupportMerge => 'Merge is not supported on Web';

  @override
  String get video1CropFailed => 'Video 1 crop failed';

  @override
  String get video2CropFailed => 'Video 2 crop failed';

  @override
  String get mergeSuccess => 'Merge successful!';

  @override
  String get mergeFailed => 'Merge failed';

  @override
  String mergeError(String error) {
    return 'Merge error: $error';
  }

  @override
  String get merging => 'Merging...';

  @override
  String get startMerge => 'Start Merge';

  @override
  String get compressVideo => 'Compress Video';

  @override
  String get compressSuccess => 'Compression complete!';

  @override
  String get compressFailed => 'Compression failed';

  @override
  String compressError(String error) {
    return 'Compression error: $error';
  }

  @override
  String originalSize(String size) {
    return 'Original size: $size';
  }

  @override
  String compressQuality(int value) {
    return 'Compression quality (CRF): $value';
  }

  @override
  String get compressTip =>
      'Higher value means more compression, lower quality';

  @override
  String get encodeSpeed => 'Encode speed:';

  @override
  String compressedSize(String size) {
    return 'Compressed: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Saved: $size ($percent%)';
  }

  @override
  String get compressing => 'Compressing...';

  @override
  String get startCompress => 'Start Compress';

  @override
  String get convertFormat => 'Convert Format';

  @override
  String get convertSuccess => 'Conversion successful!';

  @override
  String get convertFailed => 'Conversion failed';

  @override
  String convertError(String error) {
    return 'Conversion error: $error';
  }

  @override
  String get targetFormat => 'Target format:';

  @override
  String get converting => 'Converting...';

  @override
  String convertTo(String format) {
    return 'Convert to $format';
  }

  @override
  String get cropVideo => 'Crop Video';

  @override
  String get cropSuccess => 'Crop successful!';

  @override
  String get cropFailed => 'Crop failed';

  @override
  String cropError(String error) {
    return 'Crop error: $error';
  }

  @override
  String get cropPreviewFailedButSaved =>
      'Preview failed, but file has been generated';

  @override
  String originalResolution(int width, int height) {
    return 'Original: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Crop: ${width}x$height';
  }

  @override
  String get cropDragTip =>
      'Drag the green box or edges to adjust crop area, drag inside to move';

  @override
  String get resetCrop => 'Reset Crop Area';

  @override
  String get cropping => 'Cropping...';

  @override
  String get startCrop => 'Start Crop';

  @override
  String get cutVideo => 'Cut Video';

  @override
  String get cutSuccess => 'Cut successful!';

  @override
  String get cutFailed => 'Cut failed';

  @override
  String cutError(String error) {
    return 'Cut error: $error';
  }

  @override
  String get cutCompletePreviewUnavailable =>
      'Cut complete (preview unavailable)';

  @override
  String get videoPreviewUnavailable => 'Video preview unavailable';

  @override
  String totalDuration(String duration) {
    return 'Total duration: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'Cut: $start - $end  ($duration)';
  }

  @override
  String get cutting => 'Cutting...';

  @override
  String get startCut => 'Start Cut';

  @override
  String get dubbingVideo => 'Dub Video';

  @override
  String get dubbingSuccess => 'Dubbing successful!';

  @override
  String get dubbingFailed => 'Dubbing failed';

  @override
  String dubbingError(String error) {
    return 'Dubbing error: $error';
  }

  @override
  String get selectVideo => 'Select Video';

  @override
  String get videoSelected => 'Video selected';

  @override
  String get selectAudio => 'Select Audio';

  @override
  String get audioSelected => 'Audio selected';

  @override
  String get dubbingMode => 'Dubbing mode:';

  @override
  String get replaceOriginalAudio => 'Replace original audio';

  @override
  String get replaceAudioHint => 'Turn off to mix both audio tracks';

  @override
  String get dubbing => 'Dubbing...';

  @override
  String get startDubbing => 'Start Dubbing';

  @override
  String get startOver => 'Start Over';

  @override
  String get extractImages => 'Extract Images';

  @override
  String get startTimeMustBeBeforeEnd => 'Start time must be before end time';

  @override
  String extractedCount(int count) {
    return 'Extracted $count images';
  }

  @override
  String get noImagesExtracted =>
      'No images extracted, please check the video file';

  @override
  String get extractFailed => 'Extraction failed';

  @override
  String extractError(String error) {
    return 'Extraction error: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return 'Saved $count images to album';
  }

  @override
  String videoDuration(String duration) {
    return 'Video duration: $duration';
  }

  @override
  String get startTime => 'Start time';

  @override
  String get endTime => 'End time';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Extract range: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Extract rate: $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return 'About $count images will be extracted';
  }

  @override
  String get extracting => 'Extracting...';

  @override
  String get startExtract => 'Start Extract';

  @override
  String extractedImagesCount(int count) {
    return 'Extracted $count images';
  }

  @override
  String showingFirst30(int count) {
    return 'Showing first 30 of $count';
  }

  @override
  String saveAllCount(int count) {
    return 'Save all $count';
  }

  @override
  String get muteVideo => 'Mute Video';

  @override
  String get muteSuccess => 'Mute successful!';

  @override
  String get muteFailed => 'Mute failed';

  @override
  String muteError(String error) {
    return 'Mute error: $error';
  }

  @override
  String get muteDescription =>
      'All audio will be removed, only video frames retained';

  @override
  String get muting => 'Muting...';

  @override
  String get removeAudio => 'Remove Audio';

  @override
  String get ratioVideo => 'Video Ratio';

  @override
  String get ratioSuccess => 'Ratio adjusted successfully!';

  @override
  String get ratioFailed => 'Ratio adjustment failed';

  @override
  String ratioError(String error) {
    return 'Ratio error: $error';
  }

  @override
  String get targetRatio => 'Target ratio:';

  @override
  String get scaleMode => 'Scale mode:';

  @override
  String get stretchFit => 'Stretch fit';

  @override
  String get cropFill => 'Crop fill';

  @override
  String get letterbox => 'Letterbox';

  @override
  String get adjusting => 'Adjusting...';

  @override
  String get startAdjust => 'Start Adjust';

  @override
  String get separateAV => 'Separate A/V';

  @override
  String get separateComplete => 'Separation complete!';

  @override
  String get separateFailed =>
      'Separation failed, video may not contain audio/video tracks';

  @override
  String separateError(String error) {
    return 'Separation error: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Video only saved to album';

  @override
  String get saveVideoFailed => 'Save video failed';

  @override
  String saveVideoError(String error) {
    return 'Save video error: $error';
  }

  @override
  String get cannotGetDownloadDir => 'Cannot get download directory';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label saved to: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return '$label file does not exist';
  }

  @override
  String get separateDescription =>
      'Extract video frames and audio as separate files';

  @override
  String get separating => 'Separating...';

  @override
  String get startSeparate => 'Start Separate';

  @override
  String get videoOnly => 'Video only (no audio)';

  @override
  String get savedToAlbumLabel => 'Saved to album';

  @override
  String get m4aAudio => 'M4A Audio';

  @override
  String get mp3Audio => 'MP3 Audio';

  @override
  String get savedToDownloadsShort => 'Saved to Downloads';

  @override
  String get playMp3Audio => 'Play MP3 audio';

  @override
  String get playM4aAudio => 'Play M4A audio';

  @override
  String get splitVideo => 'Split Video';

  @override
  String get addAtLeastOneSplitPoint => 'Please add at least one split point';

  @override
  String splitComplete(int count) {
    return 'Split complete! $count segments';
  }

  @override
  String get splitFailed => 'Split failed';

  @override
  String splitError(String error) {
    return 'Split error: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return 'Saved $count segments to album';
  }

  @override
  String get splitPoints => 'Split points:';

  @override
  String get add => 'Add';

  @override
  String get noSplitPoints => 'No split points, tap to add';

  @override
  String splitPoint(int index) {
    return 'Split point $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'Will produce $count segments after split:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Segment $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'Splitting...';

  @override
  String get startSplit => 'Start Split';

  @override
  String saveAllSegments(int count) {
    return 'Save all $count segments';
  }

  @override
  String segment(int index) {
    return 'Segment $index';
  }

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get updateDate => 'Update date';

  @override
  String get privacyDate => 'January 1, 2025';

  @override
  String get section1Title => '1. Information Collection';

  @override
  String get section1Content =>
      'We take your privacy very seriously. This app only collects the following necessary information during service provision:';

  @override
  String get section1Item1 =>
      'Video/audio files you actively select (only used for local processing, never uploaded to any server)';

  @override
  String get section1Item2 =>
      'Basic device information (for device adaptation, does not contain personal identity information)';

  @override
  String get section2Title => '2. Information Usage';

  @override
  String get section2Content =>
      'All audio/video processing is completed locally on your device. We will never upload any of your files or data to remote servers. Collected device information is only used for feature adaptation and crash investigation.';

  @override
  String get section3Title => '3. Information Storage';

  @override
  String get section3Content =>
      'Temporary files generated by the app are stored in the device\'s local temporary directory. You can save or delete them at your discretion after processing. We do not store any of your data on servers.';

  @override
  String get section4Title => '4. Information Sharing';

  @override
  String get section4Content =>
      'We will not sell, trade, or otherwise transfer your personal information to third parties, except in the following cases:';

  @override
  String get section4Item1 => 'With your explicit consent';

  @override
  String get section4Item2 => 'As required by law or government order';

  @override
  String get section5Title => '5. Third-party Services';

  @override
  String get section5Content =>
      'This app uses some third-party SDKs to provide services, which may have their own privacy policies. Please see the \"Third-party SDK List\" page for details.';

  @override
  String get section6Title => '6. Data Security';

  @override
  String get section6Content =>
      'We take reasonable security measures to protect your information from unauthorized access, use, or disclosure. However, please note that the Internet is not absolutely secure. We recommend keeping your device safe.';

  @override
  String get section7Title => '7. Protection of Minors';

  @override
  String get section7Content =>
      'We attach great importance to protecting minors\' personal information. If you are under 18, we recommend using this app under the guidance of a guardian.';

  @override
  String get section8Title => '8. Privacy Policy Changes';

  @override
  String get section8Content =>
      'We may revise this privacy policy from time to time. When changes occur, we will notify you via in-app pop-ups or announcements.';

  @override
  String get section9Title => '9. Contact Us';

  @override
  String get section9Content =>
      'If you have any questions or suggestions about this privacy policy, please contact us at:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc =>
      'Cross-platform application development framework for building UI and interactions';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc =>
      'Audio/video processing core library for video cropping, compression, format conversion, etc.';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => 'Video playback component for video preview';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc =>
      'File selector for choosing local video and audio files';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc =>
      'Album save tool for saving processed files to system album';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc =>
      'Permission management component for requesting storage, album, and other system permissions';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc =>
      'Path provider for obtaining temporary and document directories';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc =>
      'State management library for in-app state sharing and management';

  @override
  String licenseLabel(String license) {
    return 'License: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Video initialization failed: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Failed to select video: $error';
  }
}
