import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ToolKit'**
  String get appName;

  /// No description provided for @tabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tabAll;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'Settings & About'**
  String get settingsAbout;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @appNameLabel.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appNameLabel;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @developerLabel.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developerLabel;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @viewPrivacyTerms.
  ///
  /// In en, this message translates to:
  /// **'View privacy terms'**
  String get viewPrivacyTerms;

  /// No description provided for @sdkList.
  ///
  /// In en, this message translates to:
  /// **'Third-party SDK List'**
  String get sdkList;

  /// No description provided for @viewThirdPartyServices.
  ///
  /// In en, this message translates to:
  /// **'View third-party services'**
  String get viewThirdPartyServices;

  /// No description provided for @iapDescription.
  ///
  /// In en, this message translates to:
  /// **'In-App Purchase'**
  String get iapDescription;

  /// No description provided for @viewIapDetails.
  ///
  /// In en, this message translates to:
  /// **'View in-app purchase and subscription details'**
  String get viewIapDetails;

  /// No description provided for @iapSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. In-App Purchase Items'**
  String get iapSection1Title;

  /// No description provided for @iapSection1Content.
  ///
  /// In en, this message translates to:
  /// **'This app offers a \"Premium\" in-app purchase, which is a one-time purchase, not an auto-renewing subscription. After purchase, you will permanently unlock all features, including: unlimited saves to album, unrestricted use of all tools, free future updates, and ad-free experience.'**
  String get iapSection1Content;

  /// No description provided for @iapSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Payment & Confirmation'**
  String get iapSection2Title;

  /// No description provided for @iapSection2Content.
  ///
  /// In en, this message translates to:
  /// **'The purchase will be charged to your Apple ID / Google Play account. Once confirmed, the amount will be deducted from your account.'**
  String get iapSection2Content;

  /// No description provided for @iapSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Restore Purchases'**
  String get iapSection3Title;

  /// No description provided for @iapSection3Content.
  ///
  /// In en, this message translates to:
  /// **'If you change devices or reinstall the app, you can tap \"Restore Purchases\" on the Settings or Shop page to restore your premium access for free, without paying again.'**
  String get iapSection3Content;

  /// No description provided for @iapSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Cancellation & Refund'**
  String get iapSection4Title;

  /// No description provided for @iapSection4Content.
  ///
  /// In en, this message translates to:
  /// **'This is a one-time purchase. Refunds are not supported after purchase. If you need a refund, please apply through the official Apple / Google Play channels.'**
  String get iapSection4Content;

  /// No description provided for @iapSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Contact Us'**
  String get iapSection5Title;

  /// No description provided for @iapSection5Content.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about in-app purchases, please contact:\nxinyoushanhai888@gmail.com'**
  String get iapSection5Content;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ToolKit'**
  String get welcomeTitle;

  /// No description provided for @welcomeFreeCount.
  ///
  /// In en, this message translates to:
  /// **'You have {count} free uses. Each save to album consumes 1 use.'**
  String welcomeFreeCount(int count);

  /// No description provided for @welcomeUpgradeHint.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium for unlimited access to all features'**
  String get welcomeUpgradeHint;

  /// No description provided for @welcomeGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get welcomeGotIt;

  /// No description provided for @welcomeUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get welcomeUpgrade;

  /// No description provided for @freeCountRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} remaining'**
  String freeCountRemaining(int count);

  /// No description provided for @freeCountExhausted.
  ///
  /// In en, this message translates to:
  /// **'Free uses exhausted'**
  String get freeCountExhausted;

  /// No description provided for @upgradeToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium for unlimited use'**
  String get upgradeToUnlock;

  /// No description provided for @openSourceNotice.
  ///
  /// In en, this message translates to:
  /// **'Built with FFmpeg, Flutter and other open-source technologies. Thanks to the open-source community.'**
  String get openSourceNotice;

  /// No description provided for @harmonyDeveloping.
  ///
  /// In en, this message translates to:
  /// **'HarmonyOS version is under development'**
  String get harmonyDeveloping;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @toolMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge Videos'**
  String get toolMerge;

  /// No description provided for @toolMergeDesc.
  ///
  /// In en, this message translates to:
  /// **'Merge multiple video files into one'**
  String get toolMergeDesc;

  /// No description provided for @toolCut.
  ///
  /// In en, this message translates to:
  /// **'Cut Video'**
  String get toolCut;

  /// No description provided for @toolCutDesc.
  ///
  /// In en, this message translates to:
  /// **'Extract a specific time segment from video'**
  String get toolCutDesc;

  /// No description provided for @toolCompress.
  ///
  /// In en, this message translates to:
  /// **'Compress Video'**
  String get toolCompress;

  /// No description provided for @toolCompressDesc.
  ///
  /// In en, this message translates to:
  /// **'Reduce video file size'**
  String get toolCompressDesc;

  /// No description provided for @toolRatio.
  ///
  /// In en, this message translates to:
  /// **'Video Ratio'**
  String get toolRatio;

  /// No description provided for @toolRatioDesc.
  ///
  /// In en, this message translates to:
  /// **'Adjust aspect ratio'**
  String get toolRatioDesc;

  /// No description provided for @toolMute.
  ///
  /// In en, this message translates to:
  /// **'Mute Video'**
  String get toolMute;

  /// No description provided for @toolMuteDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove audio track from video'**
  String get toolMuteDesc;

  /// No description provided for @toolDubbing.
  ///
  /// In en, this message translates to:
  /// **'Dub Video'**
  String get toolDubbing;

  /// No description provided for @toolDubbingDesc.
  ///
  /// In en, this message translates to:
  /// **'Add background music to video'**
  String get toolDubbingDesc;

  /// No description provided for @toolExtract.
  ///
  /// In en, this message translates to:
  /// **'Extract Images'**
  String get toolExtract;

  /// No description provided for @toolExtractDesc.
  ///
  /// In en, this message translates to:
  /// **'Extract frames from video as images'**
  String get toolExtractDesc;

  /// No description provided for @toolSplit.
  ///
  /// In en, this message translates to:
  /// **'Split Video'**
  String get toolSplit;

  /// No description provided for @toolSplitDesc.
  ///
  /// In en, this message translates to:
  /// **'Split video into multiple segments'**
  String get toolSplitDesc;

  /// No description provided for @toolSeparate.
  ///
  /// In en, this message translates to:
  /// **'Separate A/V'**
  String get toolSeparate;

  /// No description provided for @toolSeparateDesc.
  ///
  /// In en, this message translates to:
  /// **'Separate audio and video tracks'**
  String get toolSeparateDesc;

  /// No description provided for @toolCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop Video'**
  String get toolCrop;

  /// No description provided for @toolCropDesc.
  ///
  /// In en, this message translates to:
  /// **'Crop video frame area'**
  String get toolCropDesc;

  /// No description provided for @toolConvert.
  ///
  /// In en, this message translates to:
  /// **'Convert Format'**
  String get toolConvert;

  /// No description provided for @toolConvertDesc.
  ///
  /// In en, this message translates to:
  /// **'Convert video file format'**
  String get toolConvertDesc;

  /// No description provided for @toolCountAll.
  ///
  /// In en, this message translates to:
  /// **'{count} tools · All'**
  String toolCountAll(int count);

  /// No description provided for @featureDeveloping.
  ///
  /// In en, this message translates to:
  /// **'{name} is under development'**
  String featureDeveloping(String name);

  /// No description provided for @selectVideoFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to select video'**
  String get selectVideoFailed;

  /// No description provided for @selectAudioFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to select audio'**
  String get selectAudioFailed;

  /// No description provided for @needAlbumPermission.
  ///
  /// In en, this message translates to:
  /// **'Album permission required'**
  String get needAlbumPermission;

  /// No description provided for @savedToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Saved to album'**
  String get savedToAlbum;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Save error: {error}'**
  String saveError(String error);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @tapToSelectVideo.
  ///
  /// In en, this message translates to:
  /// **'Tap to select a video'**
  String get tapToSelectVideo;

  /// No description provided for @tapToSelectFirstVideo.
  ///
  /// In en, this message translates to:
  /// **'Tap to select the first video'**
  String get tapToSelectFirstVideo;

  /// No description provided for @tapToSelectSecondVideo.
  ///
  /// In en, this message translates to:
  /// **'Tap to select the second video'**
  String get tapToSelectSecondVideo;

  /// No description provided for @tapToPreview.
  ///
  /// In en, this message translates to:
  /// **'Tap to preview'**
  String get tapToPreview;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @reselect.
  ///
  /// In en, this message translates to:
  /// **'Reselect'**
  String get reselect;

  /// No description provided for @changeVideo.
  ///
  /// In en, this message translates to:
  /// **'Change Video'**
  String get changeVideo;

  /// No description provided for @saveToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Save to Album'**
  String get saveToAlbum;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @videoLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Video load failed'**
  String get videoLoadFailed;

  /// No description provided for @previewFailed.
  ///
  /// In en, this message translates to:
  /// **'Preview failed'**
  String get previewFailed;

  /// No description provided for @previewInitFailed.
  ///
  /// In en, this message translates to:
  /// **'Preview initialization failed'**
  String get previewInitFailed;

  /// No description provided for @mergeVideo.
  ///
  /// In en, this message translates to:
  /// **'Merge Videos'**
  String get mergeVideo;

  /// No description provided for @selectTwoVideosToMerge.
  ///
  /// In en, this message translates to:
  /// **'Select two videos to merge'**
  String get selectTwoVideosToMerge;

  /// No description provided for @video1.
  ///
  /// In en, this message translates to:
  /// **'Video 1'**
  String get video1;

  /// No description provided for @video2.
  ///
  /// In en, this message translates to:
  /// **'Video 2'**
  String get video2;

  /// No description provided for @selectVideo1.
  ///
  /// In en, this message translates to:
  /// **'Select Video 1'**
  String get selectVideo1;

  /// No description provided for @selectVideo2.
  ///
  /// In en, this message translates to:
  /// **'Select Video 2'**
  String get selectVideo2;

  /// No description provided for @pleaseSelectTwoVideos.
  ///
  /// In en, this message translates to:
  /// **'Please select two videos first'**
  String get pleaseSelectTwoVideos;

  /// No description provided for @webNotSupportMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge is not supported on Web'**
  String get webNotSupportMerge;

  /// No description provided for @video1CropFailed.
  ///
  /// In en, this message translates to:
  /// **'Video 1 crop failed'**
  String get video1CropFailed;

  /// No description provided for @video2CropFailed.
  ///
  /// In en, this message translates to:
  /// **'Video 2 crop failed'**
  String get video2CropFailed;

  /// No description provided for @mergeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Merge successful!'**
  String get mergeSuccess;

  /// No description provided for @mergeFailed.
  ///
  /// In en, this message translates to:
  /// **'Merge failed'**
  String get mergeFailed;

  /// No description provided for @mergeError.
  ///
  /// In en, this message translates to:
  /// **'Merge error: {error}'**
  String mergeError(String error);

  /// No description provided for @merging.
  ///
  /// In en, this message translates to:
  /// **'Merging...'**
  String get merging;

  /// No description provided for @startMerge.
  ///
  /// In en, this message translates to:
  /// **'Start Merge'**
  String get startMerge;

  /// No description provided for @compressVideo.
  ///
  /// In en, this message translates to:
  /// **'Compress Video'**
  String get compressVideo;

  /// No description provided for @compressSuccess.
  ///
  /// In en, this message translates to:
  /// **'Compression complete!'**
  String get compressSuccess;

  /// No description provided for @compressFailed.
  ///
  /// In en, this message translates to:
  /// **'Compression failed'**
  String get compressFailed;

  /// No description provided for @compressError.
  ///
  /// In en, this message translates to:
  /// **'Compression error: {error}'**
  String compressError(String error);

  /// No description provided for @originalSize.
  ///
  /// In en, this message translates to:
  /// **'Original size: {size}'**
  String originalSize(String size);

  /// No description provided for @compressQuality.
  ///
  /// In en, this message translates to:
  /// **'Compression quality (CRF): {value}'**
  String compressQuality(int value);

  /// No description provided for @compressTip.
  ///
  /// In en, this message translates to:
  /// **'Higher value means more compression, lower quality'**
  String get compressTip;

  /// No description provided for @encodeSpeed.
  ///
  /// In en, this message translates to:
  /// **'Encode speed:'**
  String get encodeSpeed;

  /// No description provided for @compressedSize.
  ///
  /// In en, this message translates to:
  /// **'Compressed: {size}'**
  String compressedSize(String size);

  /// No description provided for @savedSpace.
  ///
  /// In en, this message translates to:
  /// **'Saved: {size} ({percent}%)'**
  String savedSpace(String size, String percent);

  /// No description provided for @compressing.
  ///
  /// In en, this message translates to:
  /// **'Compressing...'**
  String get compressing;

  /// No description provided for @startCompress.
  ///
  /// In en, this message translates to:
  /// **'Start Compress'**
  String get startCompress;

  /// No description provided for @convertFormat.
  ///
  /// In en, this message translates to:
  /// **'Convert Format'**
  String get convertFormat;

  /// No description provided for @convertSuccess.
  ///
  /// In en, this message translates to:
  /// **'Conversion successful!'**
  String get convertSuccess;

  /// No description provided for @convertFailed.
  ///
  /// In en, this message translates to:
  /// **'Conversion failed'**
  String get convertFailed;

  /// No description provided for @convertError.
  ///
  /// In en, this message translates to:
  /// **'Conversion error: {error}'**
  String convertError(String error);

  /// No description provided for @targetFormat.
  ///
  /// In en, this message translates to:
  /// **'Target format:'**
  String get targetFormat;

  /// No description provided for @converting.
  ///
  /// In en, this message translates to:
  /// **'Converting...'**
  String get converting;

  /// No description provided for @convertTo.
  ///
  /// In en, this message translates to:
  /// **'Convert to {format}'**
  String convertTo(String format);

  /// No description provided for @cropVideo.
  ///
  /// In en, this message translates to:
  /// **'Crop Video'**
  String get cropVideo;

  /// No description provided for @cropSuccess.
  ///
  /// In en, this message translates to:
  /// **'Crop successful!'**
  String get cropSuccess;

  /// No description provided for @cropFailed.
  ///
  /// In en, this message translates to:
  /// **'Crop failed'**
  String get cropFailed;

  /// No description provided for @cropError.
  ///
  /// In en, this message translates to:
  /// **'Crop error: {error}'**
  String cropError(String error);

  /// No description provided for @cropPreviewFailedButSaved.
  ///
  /// In en, this message translates to:
  /// **'Preview failed, but file has been generated'**
  String get cropPreviewFailedButSaved;

  /// No description provided for @originalResolution.
  ///
  /// In en, this message translates to:
  /// **'Original: {width}x{height}'**
  String originalResolution(int width, int height);

  /// No description provided for @cropResolution.
  ///
  /// In en, this message translates to:
  /// **'Crop: {width}x{height}'**
  String cropResolution(int width, int height);

  /// No description provided for @cropDragTip.
  ///
  /// In en, this message translates to:
  /// **'Drag the green box or edges to adjust crop area, drag inside to move'**
  String get cropDragTip;

  /// No description provided for @resetCrop.
  ///
  /// In en, this message translates to:
  /// **'Reset Crop Area'**
  String get resetCrop;

  /// No description provided for @cropping.
  ///
  /// In en, this message translates to:
  /// **'Cropping...'**
  String get cropping;

  /// No description provided for @startCrop.
  ///
  /// In en, this message translates to:
  /// **'Start Crop'**
  String get startCrop;

  /// No description provided for @cutVideo.
  ///
  /// In en, this message translates to:
  /// **'Cut Video'**
  String get cutVideo;

  /// No description provided for @cutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cut successful!'**
  String get cutSuccess;

  /// No description provided for @cutFailed.
  ///
  /// In en, this message translates to:
  /// **'Cut failed'**
  String get cutFailed;

  /// No description provided for @cutError.
  ///
  /// In en, this message translates to:
  /// **'Cut error: {error}'**
  String cutError(String error);

  /// No description provided for @cutCompletePreviewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cut complete (preview unavailable)'**
  String get cutCompletePreviewUnavailable;

  /// No description provided for @videoPreviewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Video preview unavailable'**
  String get videoPreviewUnavailable;

  /// No description provided for @totalDuration.
  ///
  /// In en, this message translates to:
  /// **'Total duration: {duration}'**
  String totalDuration(String duration);

  /// No description provided for @cutRange.
  ///
  /// In en, this message translates to:
  /// **'Cut: {start} - {end}  ({duration})'**
  String cutRange(String start, String end, String duration);

  /// No description provided for @cutting.
  ///
  /// In en, this message translates to:
  /// **'Cutting...'**
  String get cutting;

  /// No description provided for @startCut.
  ///
  /// In en, this message translates to:
  /// **'Start Cut'**
  String get startCut;

  /// No description provided for @dubbingVideo.
  ///
  /// In en, this message translates to:
  /// **'Dub Video'**
  String get dubbingVideo;

  /// No description provided for @dubbingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Dubbing successful!'**
  String get dubbingSuccess;

  /// No description provided for @dubbingFailed.
  ///
  /// In en, this message translates to:
  /// **'Dubbing failed'**
  String get dubbingFailed;

  /// No description provided for @dubbingError.
  ///
  /// In en, this message translates to:
  /// **'Dubbing error: {error}'**
  String dubbingError(String error);

  /// No description provided for @selectVideo.
  ///
  /// In en, this message translates to:
  /// **'Select Video'**
  String get selectVideo;

  /// No description provided for @videoSelected.
  ///
  /// In en, this message translates to:
  /// **'Video selected'**
  String get videoSelected;

  /// No description provided for @selectAudio.
  ///
  /// In en, this message translates to:
  /// **'Select Audio'**
  String get selectAudio;

  /// No description provided for @audioSelected.
  ///
  /// In en, this message translates to:
  /// **'Audio selected'**
  String get audioSelected;

  /// No description provided for @dubbingMode.
  ///
  /// In en, this message translates to:
  /// **'Dubbing mode:'**
  String get dubbingMode;

  /// No description provided for @replaceOriginalAudio.
  ///
  /// In en, this message translates to:
  /// **'Replace original audio'**
  String get replaceOriginalAudio;

  /// No description provided for @replaceAudioHint.
  ///
  /// In en, this message translates to:
  /// **'Turn off to mix both audio tracks'**
  String get replaceAudioHint;

  /// No description provided for @dubbing.
  ///
  /// In en, this message translates to:
  /// **'Dubbing...'**
  String get dubbing;

  /// No description provided for @startDubbing.
  ///
  /// In en, this message translates to:
  /// **'Start Dubbing'**
  String get startDubbing;

  /// No description provided for @startOver.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get startOver;

  /// No description provided for @extractImages.
  ///
  /// In en, this message translates to:
  /// **'Extract Images'**
  String get extractImages;

  /// No description provided for @startTimeMustBeBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'Start time must be before end time'**
  String get startTimeMustBeBeforeEnd;

  /// No description provided for @extractedCount.
  ///
  /// In en, this message translates to:
  /// **'Extracted {count} images'**
  String extractedCount(int count);

  /// No description provided for @noImagesExtracted.
  ///
  /// In en, this message translates to:
  /// **'No images extracted, please check the video file'**
  String get noImagesExtracted;

  /// No description provided for @extractFailed.
  ///
  /// In en, this message translates to:
  /// **'Extraction failed'**
  String get extractFailed;

  /// No description provided for @extractError.
  ///
  /// In en, this message translates to:
  /// **'Extraction error: {error}'**
  String extractError(String error);

  /// No description provided for @savedCountToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Saved {count} images to album'**
  String savedCountToAlbum(int count);

  /// No description provided for @videoDuration.
  ///
  /// In en, this message translates to:
  /// **'Video duration: {duration}'**
  String videoDuration(String duration);

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get endTime;

  /// No description provided for @extractRange.
  ///
  /// In en, this message translates to:
  /// **'Extract range: {start} - {end}  ({duration})'**
  String extractRange(String start, String end, String duration);

  /// No description provided for @extractFps.
  ///
  /// In en, this message translates to:
  /// **'Extract rate: {fps} fps'**
  String extractFps(String fps);

  /// No description provided for @estimatedImages.
  ///
  /// In en, this message translates to:
  /// **'About {count} images will be extracted'**
  String estimatedImages(int count);

  /// No description provided for @extracting.
  ///
  /// In en, this message translates to:
  /// **'Extracting...'**
  String get extracting;

  /// No description provided for @startExtract.
  ///
  /// In en, this message translates to:
  /// **'Start Extract'**
  String get startExtract;

  /// No description provided for @extractedImagesCount.
  ///
  /// In en, this message translates to:
  /// **'Extracted {count} images'**
  String extractedImagesCount(int count);

  /// No description provided for @showingFirst30.
  ///
  /// In en, this message translates to:
  /// **'Showing first 30 of {count}'**
  String showingFirst30(int count);

  /// No description provided for @saveAllCount.
  ///
  /// In en, this message translates to:
  /// **'Save all {count}'**
  String saveAllCount(int count);

  /// No description provided for @muteVideo.
  ///
  /// In en, this message translates to:
  /// **'Mute Video'**
  String get muteVideo;

  /// No description provided for @muteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Mute successful!'**
  String get muteSuccess;

  /// No description provided for @muteFailed.
  ///
  /// In en, this message translates to:
  /// **'Mute failed'**
  String get muteFailed;

  /// No description provided for @muteError.
  ///
  /// In en, this message translates to:
  /// **'Mute error: {error}'**
  String muteError(String error);

  /// No description provided for @muteDescription.
  ///
  /// In en, this message translates to:
  /// **'All audio will be removed, only video frames retained'**
  String get muteDescription;

  /// No description provided for @muting.
  ///
  /// In en, this message translates to:
  /// **'Muting...'**
  String get muting;

  /// No description provided for @removeAudio.
  ///
  /// In en, this message translates to:
  /// **'Remove Audio'**
  String get removeAudio;

  /// No description provided for @ratioVideo.
  ///
  /// In en, this message translates to:
  /// **'Video Ratio'**
  String get ratioVideo;

  /// No description provided for @ratioSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ratio adjusted successfully!'**
  String get ratioSuccess;

  /// No description provided for @ratioFailed.
  ///
  /// In en, this message translates to:
  /// **'Ratio adjustment failed'**
  String get ratioFailed;

  /// No description provided for @ratioError.
  ///
  /// In en, this message translates to:
  /// **'Ratio error: {error}'**
  String ratioError(String error);

  /// No description provided for @targetRatio.
  ///
  /// In en, this message translates to:
  /// **'Target ratio:'**
  String get targetRatio;

  /// No description provided for @scaleMode.
  ///
  /// In en, this message translates to:
  /// **'Scale mode:'**
  String get scaleMode;

  /// No description provided for @stretchFit.
  ///
  /// In en, this message translates to:
  /// **'Stretch fit'**
  String get stretchFit;

  /// No description provided for @cropFill.
  ///
  /// In en, this message translates to:
  /// **'Crop fill'**
  String get cropFill;

  /// No description provided for @letterbox.
  ///
  /// In en, this message translates to:
  /// **'Letterbox'**
  String get letterbox;

  /// No description provided for @adjusting.
  ///
  /// In en, this message translates to:
  /// **'Adjusting...'**
  String get adjusting;

  /// No description provided for @startAdjust.
  ///
  /// In en, this message translates to:
  /// **'Start Adjust'**
  String get startAdjust;

  /// No description provided for @separateAV.
  ///
  /// In en, this message translates to:
  /// **'Separate A/V'**
  String get separateAV;

  /// No description provided for @separateComplete.
  ///
  /// In en, this message translates to:
  /// **'Separation complete!'**
  String get separateComplete;

  /// No description provided for @separateFailed.
  ///
  /// In en, this message translates to:
  /// **'Separation failed, video may not contain audio/video tracks'**
  String get separateFailed;

  /// No description provided for @separateError.
  ///
  /// In en, this message translates to:
  /// **'Separation error: {error}'**
  String separateError(String error);

  /// No description provided for @videoOnlySavedToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Video only saved to album'**
  String get videoOnlySavedToAlbum;

  /// No description provided for @saveVideoFailed.
  ///
  /// In en, this message translates to:
  /// **'Save video failed'**
  String get saveVideoFailed;

  /// No description provided for @saveVideoError.
  ///
  /// In en, this message translates to:
  /// **'Save video error: {error}'**
  String saveVideoError(String error);

  /// No description provided for @cannotGetDownloadDir.
  ///
  /// In en, this message translates to:
  /// **'Cannot get download directory'**
  String get cannotGetDownloadDir;

  /// No description provided for @savedToDownloads.
  ///
  /// In en, this message translates to:
  /// **'{label} saved to: Downloads/{fileName}'**
  String savedToDownloads(String label, String fileName);

  /// No description provided for @fileNotExist.
  ///
  /// In en, this message translates to:
  /// **'{label} file does not exist'**
  String fileNotExist(String label);

  /// No description provided for @separateDescription.
  ///
  /// In en, this message translates to:
  /// **'Extract video frames and audio as separate files'**
  String get separateDescription;

  /// No description provided for @separating.
  ///
  /// In en, this message translates to:
  /// **'Separating...'**
  String get separating;

  /// No description provided for @startSeparate.
  ///
  /// In en, this message translates to:
  /// **'Start Separate'**
  String get startSeparate;

  /// No description provided for @videoOnly.
  ///
  /// In en, this message translates to:
  /// **'Video only (no audio)'**
  String get videoOnly;

  /// No description provided for @savedToAlbumLabel.
  ///
  /// In en, this message translates to:
  /// **'Saved to album'**
  String get savedToAlbumLabel;

  /// No description provided for @m4aAudio.
  ///
  /// In en, this message translates to:
  /// **'M4A Audio'**
  String get m4aAudio;

  /// No description provided for @mp3Audio.
  ///
  /// In en, this message translates to:
  /// **'MP3 Audio'**
  String get mp3Audio;

  /// No description provided for @savedToDownloadsShort.
  ///
  /// In en, this message translates to:
  /// **'Saved to Downloads'**
  String get savedToDownloadsShort;

  /// No description provided for @playMp3Audio.
  ///
  /// In en, this message translates to:
  /// **'Play MP3 audio'**
  String get playMp3Audio;

  /// No description provided for @playM4aAudio.
  ///
  /// In en, this message translates to:
  /// **'Play M4A audio'**
  String get playM4aAudio;

  /// No description provided for @splitVideo.
  ///
  /// In en, this message translates to:
  /// **'Split Video'**
  String get splitVideo;

  /// No description provided for @addAtLeastOneSplitPoint.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one split point'**
  String get addAtLeastOneSplitPoint;

  /// No description provided for @splitComplete.
  ///
  /// In en, this message translates to:
  /// **'Split complete! {count} segments'**
  String splitComplete(int count);

  /// No description provided for @splitFailed.
  ///
  /// In en, this message translates to:
  /// **'Split failed'**
  String get splitFailed;

  /// No description provided for @splitError.
  ///
  /// In en, this message translates to:
  /// **'Split error: {error}'**
  String splitError(String error);

  /// No description provided for @savedSegmentsToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Saved {count} segments to album'**
  String savedSegmentsToAlbum(int count);

  /// No description provided for @splitPoints.
  ///
  /// In en, this message translates to:
  /// **'Split points:'**
  String get splitPoints;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noSplitPoints.
  ///
  /// In en, this message translates to:
  /// **'No split points, tap to add'**
  String get noSplitPoints;

  /// No description provided for @splitPoint.
  ///
  /// In en, this message translates to:
  /// **'Split point {index}:'**
  String splitPoint(int index);

  /// No description provided for @willProduceSegments.
  ///
  /// In en, this message translates to:
  /// **'Will produce {count} segments after split:'**
  String willProduceSegments(int count);

  /// No description provided for @segmentInfo.
  ///
  /// In en, this message translates to:
  /// **'Segment {index}: {start}-{end} ({duration})'**
  String segmentInfo(int index, String start, String end, String duration);

  /// No description provided for @splitting.
  ///
  /// In en, this message translates to:
  /// **'Splitting...'**
  String get splitting;

  /// No description provided for @startSplit.
  ///
  /// In en, this message translates to:
  /// **'Start Split'**
  String get startSplit;

  /// No description provided for @saveAllSegments.
  ///
  /// In en, this message translates to:
  /// **'Save all {count} segments'**
  String saveAllSegments(int count);

  /// No description provided for @segment.
  ///
  /// In en, this message translates to:
  /// **'Segment {index}'**
  String segment(int index);

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @updateDate.
  ///
  /// In en, this message translates to:
  /// **'Update date'**
  String get updateDate;

  /// No description provided for @privacyDate.
  ///
  /// In en, this message translates to:
  /// **'January 1, 2025'**
  String get privacyDate;

  /// No description provided for @section1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Information Collection'**
  String get section1Title;

  /// No description provided for @section1Content.
  ///
  /// In en, this message translates to:
  /// **'We take your privacy very seriously. This app only collects the following necessary information during service provision:'**
  String get section1Content;

  /// No description provided for @section1Item1.
  ///
  /// In en, this message translates to:
  /// **'Video/audio files you actively select (only used for local processing, never uploaded to any server)'**
  String get section1Item1;

  /// No description provided for @section1Item2.
  ///
  /// In en, this message translates to:
  /// **'Basic device information (for device adaptation, does not contain personal identity information)'**
  String get section1Item2;

  /// No description provided for @section2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Information Usage'**
  String get section2Title;

  /// No description provided for @section2Content.
  ///
  /// In en, this message translates to:
  /// **'All audio/video processing is completed locally on your device. We will never upload any of your files or data to remote servers. Collected device information is only used for feature adaptation and crash investigation.'**
  String get section2Content;

  /// No description provided for @section3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Information Storage'**
  String get section3Title;

  /// No description provided for @section3Content.
  ///
  /// In en, this message translates to:
  /// **'Temporary files generated by the app are stored in the device\'s local temporary directory. You can save or delete them at your discretion after processing. We do not store any of your data on servers.'**
  String get section3Content;

  /// No description provided for @section4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Information Sharing'**
  String get section4Title;

  /// No description provided for @section4Content.
  ///
  /// In en, this message translates to:
  /// **'We will not sell, trade, or otherwise transfer your personal information to third parties, except in the following cases:'**
  String get section4Content;

  /// No description provided for @section4Item1.
  ///
  /// In en, this message translates to:
  /// **'With your explicit consent'**
  String get section4Item1;

  /// No description provided for @section4Item2.
  ///
  /// In en, this message translates to:
  /// **'As required by law or government order'**
  String get section4Item2;

  /// No description provided for @section5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Third-party Services'**
  String get section5Title;

  /// No description provided for @section5Content.
  ///
  /// In en, this message translates to:
  /// **'This app uses some third-party SDKs to provide services, which may have their own privacy policies. Please see the \"Third-party SDK List\" page for details.'**
  String get section5Content;

  /// No description provided for @section6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Data Security'**
  String get section6Title;

  /// No description provided for @section6Content.
  ///
  /// In en, this message translates to:
  /// **'We take reasonable security measures to protect your information from unauthorized access, use, or disclosure. However, please note that the Internet is not absolutely secure. We recommend keeping your device safe.'**
  String get section6Content;

  /// No description provided for @section7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Protection of Minors'**
  String get section7Title;

  /// No description provided for @section7Content.
  ///
  /// In en, this message translates to:
  /// **'We attach great importance to protecting minors\' personal information. If you are under 18, we recommend using this app under the guidance of a guardian.'**
  String get section7Content;

  /// No description provided for @section8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Privacy Policy Changes'**
  String get section8Title;

  /// No description provided for @section8Content.
  ///
  /// In en, this message translates to:
  /// **'We may revise this privacy policy from time to time. When changes occur, we will notify you via in-app pop-ups or announcements.'**
  String get section8Content;

  /// No description provided for @section9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Contact Us'**
  String get section9Title;

  /// No description provided for @section9Content.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions or suggestions about this privacy policy, please contact us at:\nxinyoushanhai888@gmail.com'**
  String get section9Content;

  /// No description provided for @sdkFlutterTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get sdkFlutterTitle;

  /// No description provided for @sdkFlutterDesc.
  ///
  /// In en, this message translates to:
  /// **'Cross-platform application development framework for building UI and interactions'**
  String get sdkFlutterDesc;

  /// No description provided for @sdkFfmpegTitle.
  ///
  /// In en, this message translates to:
  /// **'FFmpeg'**
  String get sdkFfmpegTitle;

  /// No description provided for @sdkFfmpegDesc.
  ///
  /// In en, this message translates to:
  /// **'Audio/video processing core library for video cropping, compression, format conversion, etc.'**
  String get sdkFfmpegDesc;

  /// No description provided for @sdkVideoPlayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Video Player'**
  String get sdkVideoPlayerTitle;

  /// No description provided for @sdkVideoPlayerDesc.
  ///
  /// In en, this message translates to:
  /// **'Video playback component for video preview'**
  String get sdkVideoPlayerDesc;

  /// No description provided for @sdkFilePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'File Picker'**
  String get sdkFilePickerTitle;

  /// No description provided for @sdkFilePickerDesc.
  ///
  /// In en, this message translates to:
  /// **'File selector for choosing local video and audio files'**
  String get sdkFilePickerDesc;

  /// No description provided for @sdkGallerySaverTitle.
  ///
  /// In en, this message translates to:
  /// **'Gallery Saver'**
  String get sdkGallerySaverTitle;

  /// No description provided for @sdkGallerySaverDesc.
  ///
  /// In en, this message translates to:
  /// **'Album save tool for saving processed files to system album'**
  String get sdkGallerySaverDesc;

  /// No description provided for @sdkPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Permission Handler'**
  String get sdkPermissionTitle;

  /// No description provided for @sdkPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Permission management component for requesting storage, album, and other system permissions'**
  String get sdkPermissionDesc;

  /// No description provided for @sdkPathProviderTitle.
  ///
  /// In en, this message translates to:
  /// **'Path Provider'**
  String get sdkPathProviderTitle;

  /// No description provided for @sdkPathProviderDesc.
  ///
  /// In en, this message translates to:
  /// **'Path provider for obtaining temporary and document directories'**
  String get sdkPathProviderDesc;

  /// No description provided for @sdkProviderTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get sdkProviderTitle;

  /// No description provided for @sdkProviderDesc.
  ///
  /// In en, this message translates to:
  /// **'State management library for in-app state sharing and management'**
  String get sdkProviderDesc;

  /// No description provided for @licenseLabel.
  ///
  /// In en, this message translates to:
  /// **'License: {license}'**
  String licenseLabel(String license);

  /// No description provided for @videoInitFailed.
  ///
  /// In en, this message translates to:
  /// **'Video initialization failed: {error}'**
  String videoInitFailed(String error);

  /// No description provided for @selectVideoFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to select video: {error}'**
  String selectVideoFailedWithError(String error);

  /// No description provided for @premiumVersion.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumVersion;

  /// No description provided for @alreadyPremium.
  ///
  /// In en, this message translates to:
  /// **'You are already a Premium user!'**
  String get alreadyPremium;

  /// No description provided for @alreadyPremiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support, all features are unlocked'**
  String get alreadyPremiumDesc;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock Premium'**
  String get unlockPremium;

  /// No description provided for @unlockPremiumDesc.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase, permanent access to all features'**
  String get unlockPremiumDesc;

  /// No description provided for @featureUnlimitedSave.
  ///
  /// In en, this message translates to:
  /// **'Unlimited saves to album'**
  String get featureUnlimitedSave;

  /// No description provided for @featureUnlimitedTools.
  ///
  /// In en, this message translates to:
  /// **'Unrestricted use of all tools'**
  String get featureUnlimitedTools;

  /// No description provided for @featureFreeUpdates.
  ///
  /// In en, this message translates to:
  /// **'Free future updates'**
  String get featureFreeUpdates;

  /// No description provided for @featureNoAds.
  ///
  /// In en, this message translates to:
  /// **'Ad-free experience'**
  String get featureNoAds;

  /// No description provided for @unlockNow.
  ///
  /// In en, this message translates to:
  /// **'Unlock Now'**
  String get unlockNow;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @video1LoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Video 1 load failed'**
  String get video1LoadFailed;

  /// No description provided for @video2LoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Video 2 load failed'**
  String get video2LoadFailed;

  /// No description provided for @selectVideoLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Video'**
  String get selectVideoLabel;

  /// No description provided for @videoChanged.
  ///
  /// In en, this message translates to:
  /// **'Change Video'**
  String get videoChanged;

  /// No description provided for @saveVideoOnly.
  ///
  /// In en, this message translates to:
  /// **'Save Video Only'**
  String get saveVideoOnly;

  /// No description provided for @videoOnlySaved.
  ///
  /// In en, this message translates to:
  /// **'Video only saved'**
  String get videoOnlySaved;

  /// No description provided for @sourceFileNotExist.
  ///
  /// In en, this message translates to:
  /// **'Source file does not exist'**
  String get sourceFileNotExist;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save {label}'**
  String saveLabel(String label);

  /// No description provided for @labelSaved.
  ///
  /// In en, this message translates to:
  /// **'{label} saved'**
  String labelSaved(String label);

  /// No description provided for @saveLabelError.
  ///
  /// In en, this message translates to:
  /// **'Save error: {error}'**
  String saveLabelError(String error);

  /// No description provided for @noImagesExtractedShort.
  ///
  /// In en, this message translates to:
  /// **'No images extracted'**
  String get noImagesExtractedShort;

  /// No description provided for @reMerge.
  ///
  /// In en, this message translates to:
  /// **'Re-merge'**
  String get reMerge;

  /// No description provided for @originalLabel.
  ///
  /// In en, this message translates to:
  /// **'Original:'**
  String get originalLabel;

  /// No description provided for @segmentCount.
  ///
  /// In en, this message translates to:
  /// **'segments'**
  String get segmentCount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
