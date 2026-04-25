// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Video ToolKit';

  @override
  String get tabAll => 'すべて';

  @override
  String get tabSettings => '設定';

  @override
  String get settingsAbout => '設定とアプリ情報';

  @override
  String get appearance => '外観設定';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get aboutApp => 'アプリについて';

  @override
  String get appNameLabel => 'アプリ名';

  @override
  String get versionLabel => 'バージョン';

  @override
  String get developerLabel => '開発者';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get viewPrivacyTerms => 'プライバシー規約を表示';

  @override
  String get sdkList => 'サードパーティSDK一覧';

  @override
  String get viewThirdPartyServices => 'サードパーティサービスを表示';

  @override
  String get openSourceNotice =>
      'FFmpeg、Flutterなどのオープンソース技術で構築されています。オープンソースコミュニティに感謝します。';

  @override
  String get harmonyDeveloping => 'HarmonyOS版は開発中です';

  @override
  String get language => '言語';

  @override
  String get toolMerge => '動画の結合';

  @override
  String get toolMergeDesc => '複数の動画ファイルを1つに結合';

  @override
  String get toolCut => '動画の切り取り';

  @override
  String get toolCutDesc => '動画から特定の時間帯を切り取り';

  @override
  String get toolCompress => '動画の圧縮';

  @override
  String get toolCompressDesc => '動画ファイルサイズを縮小';

  @override
  String get toolRatio => '動画の比率';

  @override
  String get toolRatioDesc => 'アスペクト比を調整';

  @override
  String get toolMute => '動画のミュート';

  @override
  String get toolMuteDesc => '動画から音声トラックを削除';

  @override
  String get toolDubbing => '動画のダビング';

  @override
  String get toolDubbingDesc => '動画にBGMを追加';

  @override
  String get toolExtract => '画像の抽出';

  @override
  String get toolExtractDesc => '動画からフレームを画像として抽出';

  @override
  String get toolSplit => '動画の分割';

  @override
  String get toolSplitDesc => '動画を複数のセグメントに分割';

  @override
  String get toolSeparate => '音声・動画の分離';

  @override
  String get toolSeparateDesc => '音声と動画トラックを分離';

  @override
  String get toolCrop => '動画のクロップ';

  @override
  String get toolCropDesc => '動画のフレーム領域をクロップ';

  @override
  String get toolConvert => '形式の変換';

  @override
  String get toolConvertDesc => '動画ファイル形式を変換';

  @override
  String toolCountAll(int count) {
    return '$count ツール · すべて';
  }

  @override
  String featureDeveloping(String name) {
    return '$name は開発中です';
  }

  @override
  String get selectVideoFailed => '動画の選択に失敗しました';

  @override
  String get selectAudioFailed => '音声の選択に失敗しました';

  @override
  String get needAlbumPermission => 'アルバムの許可が必要です';

  @override
  String get savedToAlbum => 'アルバムに保存しました';

  @override
  String get saveFailed => '保存に失敗しました';

  @override
  String saveError(String error) {
    return '保存エラー: $error';
  }

  @override
  String get loading => '読み込み中...';

  @override
  String get tapToSelectVideo => 'タップして動画を選択';

  @override
  String get tapToSelectFirstVideo => 'タップして最初の動画を選択';

  @override
  String get tapToSelectSecondVideo => 'タップして2番目の動画を選択';

  @override
  String get tapToPreview => 'タップしてプレビュー';

  @override
  String get start => '開始';

  @override
  String get end => '終了';

  @override
  String get change => '変更';

  @override
  String get reselect => '再選択';

  @override
  String get changeVideo => '動画を変更';

  @override
  String get saveToAlbum => 'アルバムに保存';

  @override
  String get processing => '処理中...';

  @override
  String get videoLoadFailed => '動画の読み込みに失敗しました';

  @override
  String get previewFailed => 'プレビューに失敗しました';

  @override
  String get previewInitFailed => 'プレビューの初期化に失敗しました';

  @override
  String get mergeVideo => '動画の結合';

  @override
  String get selectTwoVideosToMerge => '結合する2つの動画を選択';

  @override
  String get video1 => '動画 1';

  @override
  String get video2 => '動画 2';

  @override
  String get selectVideo1 => '動画1を選択';

  @override
  String get selectVideo2 => '動画2を選択';

  @override
  String get pleaseSelectTwoVideos => '2つの動画を選択してください';

  @override
  String get webNotSupportMerge => 'Web版では結合をサポートしていません';

  @override
  String get video1CropFailed => '動画1のクロップに失敗しました';

  @override
  String get video2CropFailed => '動画2のクロップに失敗しました';

  @override
  String get mergeSuccess => '結合成功！';

  @override
  String get mergeFailed => '結合に失敗しました';

  @override
  String mergeError(String error) {
    return '結合エラー: $error';
  }

  @override
  String get merging => '結合中...';

  @override
  String get startMerge => '結合を開始';

  @override
  String get compressVideo => '動画の圧縮';

  @override
  String get compressSuccess => '圧縮完了！';

  @override
  String get compressFailed => '圧縮に失敗しました';

  @override
  String compressError(String error) {
    return '圧縮エラー: $error';
  }

  @override
  String originalSize(String size) {
    return '元のサイズ: $size';
  }

  @override
  String compressQuality(int value) {
    return '圧縮品質 (CRF): $value';
  }

  @override
  String get compressTip => '数値が大きいほど圧縮率が高く、画質が低下します';

  @override
  String get encodeSpeed => 'エンコード速度:';

  @override
  String compressedSize(String size) {
    return '圧縮後: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return '節約: $size ($percent%)';
  }

  @override
  String get compressing => '圧縮中...';

  @override
  String get startCompress => '圧縮を開始';

  @override
  String get convertFormat => '形式の変換';

  @override
  String get convertSuccess => '変換成功！';

  @override
  String get convertFailed => '変換に失敗しました';

  @override
  String convertError(String error) {
    return '変換エラー: $error';
  }

  @override
  String get targetFormat => '対象形式:';

  @override
  String get converting => '変換中...';

  @override
  String convertTo(String format) {
    return '$format に変換';
  }

  @override
  String get cropVideo => '動画のクロップ';

  @override
  String get cropSuccess => 'クロップ成功！';

  @override
  String get cropFailed => 'クロップに失敗しました';

  @override
  String cropError(String error) {
    return 'クロップエラー: $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'プレビューに失敗しましたが、ファイルは生成されています';

  @override
  String originalResolution(int width, int height) {
    return '元の解像度: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'クロップ: ${width}x$height';
  }

  @override
  String get cropDragTip => '緑の枠または辺をドラッグしてクロップ領域を調整、枠内をドラッグして移動';

  @override
  String get resetCrop => 'クロップ領域をリセット';

  @override
  String get cropping => 'クロップ中...';

  @override
  String get startCrop => 'クロップを開始';

  @override
  String get cutVideo => '動画の切り取り';

  @override
  String get cutSuccess => '切り取り成功！';

  @override
  String get cutFailed => '切り取りに失敗しました';

  @override
  String cutError(String error) {
    return '切り取りエラー: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => '切り取り完了（プレビュー不可）';

  @override
  String get videoPreviewUnavailable => '動画プレビュー不可';

  @override
  String totalDuration(String duration) {
    return '合計時間: $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return '切り取り: $start - $end  ($duration)';
  }

  @override
  String get cutting => '切り取り中...';

  @override
  String get startCut => '切り取りを開始';

  @override
  String get dubbingVideo => '動画のダビング';

  @override
  String get dubbingSuccess => 'ダビング成功！';

  @override
  String get dubbingFailed => 'ダビングに失敗しました';

  @override
  String dubbingError(String error) {
    return 'ダビングエラー: $error';
  }

  @override
  String get selectVideo => '動画を選択';

  @override
  String get videoSelected => '動画が選択されました';

  @override
  String get selectAudio => '音声を選択';

  @override
  String get audioSelected => '音声が選択されました';

  @override
  String get dubbingMode => 'ダビングモード:';

  @override
  String get replaceOriginalAudio => '元の音声を置き換え';

  @override
  String get replaceAudioHint => 'オフにすると両方の音声をミックスします';

  @override
  String get dubbing => 'ダビング中...';

  @override
  String get startDubbing => 'ダビングを開始';

  @override
  String get startOver => 'やり直す';

  @override
  String get extractImages => '画像の抽出';

  @override
  String get startTimeMustBeBeforeEnd => '開始時間は終了時間より前である必要があります';

  @override
  String extractedCount(int count) {
    return '$count 枚の画像を抽出しました';
  }

  @override
  String get noImagesExtracted => '画像を抽出できませんでした。動画ファイルを確認してください';

  @override
  String get extractFailed => '抽出に失敗しました';

  @override
  String extractError(String error) {
    return '抽出エラー: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return '$count 枚の画像をアルバムに保存しました';
  }

  @override
  String videoDuration(String duration) {
    return '動画の長さ: $duration';
  }

  @override
  String get startTime => '開始時間';

  @override
  String get endTime => '終了時間';

  @override
  String extractRange(String start, String end, String duration) {
    return '抽出範囲: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return '抽出レート: $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return '約 $count 枚の画像が抽出されます';
  }

  @override
  String get extracting => '抽出中...';

  @override
  String get startExtract => '抽出を開始';

  @override
  String extractedImagesCount(int count) {
    return '$count 枚の画像を抽出しました';
  }

  @override
  String showingFirst30(int count) {
    return '最初の30枚を表示（全 $count 枚）';
  }

  @override
  String saveAllCount(int count) {
    return 'すべて保存 ($count 枚)';
  }

  @override
  String get muteVideo => '動画のミュート';

  @override
  String get muteSuccess => 'ミュート成功！';

  @override
  String get muteFailed => 'ミュートに失敗しました';

  @override
  String muteError(String error) {
    return 'ミュートエラー: $error';
  }

  @override
  String get muteDescription => 'すべての音声が削除され、動画フレームのみ残ります';

  @override
  String get muting => 'ミュート中...';

  @override
  String get removeAudio => '音声を削除';

  @override
  String get ratioVideo => '動画の比率';

  @override
  String get ratioSuccess => '比率の調整に成功しました！';

  @override
  String get ratioFailed => '比率の調整に失敗しました';

  @override
  String ratioError(String error) {
    return '比率エラー: $error';
  }

  @override
  String get targetRatio => '対象比率:';

  @override
  String get scaleMode => 'スケールモード:';

  @override
  String get stretchFit => 'ストレッチフィット';

  @override
  String get cropFill => 'クロップフィル';

  @override
  String get letterbox => 'レターボックス';

  @override
  String get adjusting => '調整中...';

  @override
  String get startAdjust => '調整を開始';

  @override
  String get separateAV => '音声・動画の分離';

  @override
  String get separateComplete => '分離完了！';

  @override
  String get separateFailed => '分離に失敗しました。動画に音声/動画トラックが含まれていない可能性があります';

  @override
  String separateError(String error) {
    return '分離エラー: $error';
  }

  @override
  String get videoOnlySavedToAlbum => '動画のみアルバムに保存しました';

  @override
  String get saveVideoFailed => '動画の保存に失敗しました';

  @override
  String saveVideoError(String error) {
    return '動画保存エラー: $error';
  }

  @override
  String get cannotGetDownloadDir => 'ダウンロードディレクトリを取得できません';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label を保存しました: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return '$label ファイルが存在しません';
  }

  @override
  String get separateDescription => '動画のフレームと音声を別々のファイルとして抽出します';

  @override
  String get separating => '分離中...';

  @override
  String get startSeparate => '分離を開始';

  @override
  String get videoOnly => '動画のみ（音声なし）';

  @override
  String get savedToAlbumLabel => 'アルバムに保存しました';

  @override
  String get m4aAudio => 'M4A 音声';

  @override
  String get mp3Audio => 'MP3 音声';

  @override
  String get savedToDownloadsShort => 'Downloads に保存しました';

  @override
  String get playMp3Audio => 'MP3 音声を再生';

  @override
  String get playM4aAudio => 'M4A 音声を再生';

  @override
  String get splitVideo => '動画の分割';

  @override
  String get addAtLeastOneSplitPoint => '分割ポイントを少なくとも1つ追加してください';

  @override
  String splitComplete(int count) {
    return '分割完了！$count セグメント';
  }

  @override
  String get splitFailed => '分割に失敗しました';

  @override
  String splitError(String error) {
    return '分割エラー: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return '$count セグメントをアルバムに保存しました';
  }

  @override
  String get splitPoints => '分割ポイント:';

  @override
  String get add => '追加';

  @override
  String get noSplitPoints => '分割ポイントがありません。タップして追加';

  @override
  String splitPoint(int index) {
    return '分割ポイント $index:';
  }

  @override
  String willProduceSegments(int count) {
    return '分割後に $count セグメントが生成されます:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'セグメント $index: $start-$end ($duration)';
  }

  @override
  String get splitting => '分割中...';

  @override
  String get startSplit => '分割を開始';

  @override
  String saveAllSegments(int count) {
    return 'すべて保存 ($count セグメント)';
  }

  @override
  String segment(int index) {
    return 'セグメント $index';
  }

  @override
  String get privacyTitle => 'プライバシーポリシー';

  @override
  String get updateDate => '更新日';

  @override
  String get privacyDate => '2025年1月1日';

  @override
  String get section1Title => '1. 情報の収集';

  @override
  String get section1Content =>
      'お客様のプライバシーを非常に重視しております。本アプリはサービス提供において以下の必要な情報のみを収集します：';

  @override
  String get section1Item1 =>
      'お客様が選択した動画/音声ファイル（ローカル処理のみに使用し、サーバーにはアップロードされません）';

  @override
  String get section1Item2 => 'デバイスの基本情報（デバイス適用に使用し、個人識別情報は含まれません）';

  @override
  String get section2Title => '2. 情報の利用';

  @override
  String get section2Content =>
      'すべての音声/動画処理はお客様のデバイス上でローカルに完了します。お客様のファイルやデータをリモートサーバーにアップロードすることはありません。収集したデバイス情報は機能適合とクラッシュ調査にのみ使用します。';

  @override
  String get section3Title => '3. 情報の保存';

  @override
  String get section3Content =>
      'アプリで生成された一時ファイルはデバイスのローカル一時ディレクトリに保存されます。処理完了後、お客様の裁量で保存または削除できます。サーバー側にお客様のデータを保存することはありません。';

  @override
  String get section4Title => '4. 情報の共有';

  @override
  String get section4Content =>
      'お客様の個人情報を第三者に販売、取引、または譲渡することはありません。以下の場合を除きます：';

  @override
  String get section4Item1 => 'お客様の明示的な同意を得た場合';

  @override
  String get section4Item2 => '法令または政府の要請による場合';

  @override
  String get section5Title => '5. サードパーティサービス';

  @override
  String get section5Content =>
      '本アプリは一部のサードパーティSDKを使用してサービスを提供しています。これらのSDKには独自のプライバシーポリシーがある場合があります。詳細は「サードパーティSDK一覧」ページをご覧ください。';

  @override
  String get section6Title => '6. データセキュリティ';

  @override
  String get section6Content =>
      'お客様の情報を不正なアクセス、使用、または開示から保護するため、合理的なセキュリティ措置を講じています。ただし、インターネット環境は絶対的に安全ではないことにご留意ください。デバイスの安全な管理をお勧めします。';

  @override
  String get section7Title => '7. 未成年者の保護';

  @override
  String get section7Content =>
      '未成年者の個人情報の保護を非常に重視しています。18歳未満の方は、保護者の指導の下で本アプリをご利用ください。';

  @override
  String get section8Title => '8. プライバシーポリシーの変更';

  @override
  String get section8Content =>
      '本プライバシーポリシーを適時改訂する場合があります。変更があった場合、アプリ内のポップアップまたはお知らせでお客様に通知します。';

  @override
  String get section9Title => '9. お問い合わせ';

  @override
  String get section9Content =>
      '本プライバシーポリシーに関するご質問やご提案がございましたら、以下までご連絡ください：\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'クロスプラットフォームアプリ開発フレームワーク、UIとインタラクションの構築に使用';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => '音声/動画処理コアライブラリ、動画のクロップ、圧縮、形式変換などに使用';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => '動画再生コンポーネント、動画プレビュー機能に使用';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc => 'ファイルセレクター、ローカル動画と音声ファイルの選択に使用';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc => 'アルバム保存ツール、処理済みファイルのシステムアルバムへの保存に使用';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc => '権限管理コンポーネント、ストレージやアルバムなどのシステム権限の要求に使用';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc => 'パスプロバイダー、一時ディレクトリやドキュメントディレクトリの取得に使用';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'ステート管理ライブラリ、アプリ内のステート共有と管理に使用';

  @override
  String licenseLabel(String license) {
    return 'ライセンス: $license';
  }

  @override
  String videoInitFailed(String error) {
    return '動画の初期化に失敗しました: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return '動画の選択に失敗しました: $error';
  }
}
