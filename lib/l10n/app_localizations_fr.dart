import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => 'Tout';

  @override
  String get tabSettings => 'Paramètres';

  @override
  String get settingsAbout => 'Paramètres & À propos';

  @override
  String get appearance => 'Apparence';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get autoMode => 'Auto (17h)';

  @override
  String get aboutApp => 'À propos';

  @override
  String get appNameLabel => 'Nom de l\'application';

  @override
  String get versionLabel => 'Version';

  @override
  String get developerLabel => 'Développeur';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get viewPrivacyTerms => 'Voir les conditions de confidentialité';

  @override
  String get sdkList => 'Liste des SDK tiers';

  @override
  String get viewThirdPartyServices => 'Voir les services tiers';

  @override
  String get iapDescription => 'Achat intégré';

  @override
  String get viewIapDetails => 'Voir les détails d\'achat et d\'abonnement';

  @override
  String get iapSection1Title => '1. Articles d\'achat intégré';

  @override
  String get iapSection1Content => 'Cette application propose un achat intégré « Premium », qui est un achat unique, non un abonnement à renouvellement automatique. Après l\'achat, vous débloquerez définitivement toutes les fonctionnalités, notamment : sauvegardes illimitées dans l\'album, utilisation illimitée de tous les outils, mises à jour futures gratuites et expérience sans publicité.';

  @override
  String get iapSection2Title => '2. Paiement et confirmation';

  @override
  String get iapSection2Content => 'L\'achat sera débité de votre identifiant Apple / compte Google Play. Une fois confirmé, le montant sera déduit de votre compte.';

  @override
  String get iapSection3Title => '3. Restaurer les achats';

  @override
  String get iapSection3Content => 'Si vous changez d\'appareil ou réinstallez l\'application, vous pouvez appuyer sur « Restaurer les achats » sur la page Paramètres ou Boutique pour restaurer gratuitement votre accès Premium, sans payer à nouveau.';

  @override
  String get iapSection4Title => '4. Annulation et remboursement';

  @override
  String get iapSection4Content => 'Il s\'agit d\'un achat unique. Les remboursements ne sont pas pris en charge après l\'achat. Si vous avez besoin d\'un remboursement, veuillez faire une demande via les canaux officiels Apple / Google Play.';

  @override
  String get iapSection5Title => '5. Nous contacter';

  @override
  String get iapSection5Content => 'Si vous avez des questions sur les achats intégrés, veuillez contacter :\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => 'Bienvenue dans ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return 'Vous avez $count utilisations gratuites. Chaque sauvegarde dans l\'album consomme 1 utilisation.';
  }

  @override
  String get welcomeUpgradeHint => 'Passez à Premium pour un accès illimité à toutes les fonctionnalités';

  @override
  String get welcomeGotIt => 'Compris';

  @override
  String get welcomeUpgrade => 'Passer à Premium';

  @override
  String freeCountRemaining(int count) {
    return '$count restantes';
  }

  @override
  String get freeCountExhausted => 'Utilisations gratuites épuisées';

  @override
  String get upgradeToUnlock => 'Passez à Premium pour une utilisation illimitée';

  @override
  String get openSourceNotice => 'Construit avec FFmpeg, Flutter et d\'autres technologies open-source. Merci à la communauté open-source.';

  @override
  String get harmonyDeveloping => 'La version HarmonyOS est en cours de développement';

  @override
  String get language => 'Langue';

  @override
  String get toolMerge => 'Fusionner des vidéos';

  @override
  String get toolMergeDesc => 'Fusionner plusieurs fichiers vidéo en un seul';

  @override
  String get toolCut => 'Couper la vidéo';

  @override
  String get toolCutDesc => 'Extraire un segment temporel spécifique de la vidéo';

  @override
  String get toolCompress => 'Compresser la vidéo';

  @override
  String get toolCompressDesc => 'Réduire la taille du fichier vidéo';

  @override
  String get toolRatio => 'Ratio vidéo';

  @override
  String get toolRatioDesc => 'Ajuster le rapport d\'aspect';

  @override
  String get toolMute => 'Rendre muet';

  @override
  String get toolMuteDesc => 'Supprimer la piste audio de la vidéo';

  @override
  String get toolDubbing => 'Doublage vidéo';

  @override
  String get toolDubbingDesc => 'Ajouter une musique de fond à la vidéo';

  @override
  String get toolExtract => 'Extraire des images';

  @override
  String get toolExtractDesc => 'Extraire des images de la vidéo';

  @override
  String get toolSplit => 'Diviser la vidéo';

  @override
  String get toolSplitDesc => 'Diviser la vidéo en plusieurs segments';

  @override
  String get toolSeparate => 'Séparer A/V';

  @override
  String get toolSeparateDesc => 'Séparer les pistes audio et vidéo';

  @override
  String get toolCrop => 'Rogner la vidéo';

  @override
  String get toolCropDesc => 'Rogner la zone de l\'image vidéo';

  @override
  String get toolConvert => 'Convertir le format';

  @override
  String get toolConvertDesc => 'Convertir le format du fichier vidéo';

  @override
  String toolCountAll(int count) {
    return '$count outils · Tout';
  }

  @override
  String featureDeveloping(String name) {
    return '$name est en cours de développement';
  }

  @override
  String get selectVideoFailed => 'Échec de la sélection de la vidéo';

  @override
  String get selectAudioFailed => 'Échec de la sélection de l\'audio';

  @override
  String get needAlbumPermission => 'Permission d\'accès à l\'album requise';

  @override
  String get savedToAlbum => 'Sauvegardé dans l\'album';

  @override
  String get saveFailed => 'Échec de la sauvegarde';

  @override
  String saveError(String error) {
    return 'Erreur de sauvegarde : $error';
  }

  @override
  String get loading => 'Chargement...';

  @override
  String get tapToSelectVideo => 'Appuyez pour sélectionner une vidéo';

  @override
  String get tapToSelectFirstVideo => 'Sélectionner première vidéo';

  @override
  String get tapToSelectSecondVideo => 'Sélectionner deuxième vidéo';

  @override
  String get tapToPreview => 'Appuyez pour prévisualiser';

  @override
  String get start => 'Début';

  @override
  String get end => 'Fin';

  @override
  String get change => 'Changer';

  @override
  String get reselect => 'Resélectionner';

  @override
  String get changeVideo => 'Changer la vidéo';

  @override
  String get saveToAlbum => 'Sauvegarder dans l\'album';

  @override
  String get processing => 'Traitement...';

  @override
  String get videoLoadFailed => 'Échec du chargement de la vidéo';

  @override
  String get previewFailed => 'Échec de la prévisualisation';

  @override
  String get previewInitFailed => 'Échec de l\'initialisation de la prévisualisation';

  @override
  String get mergeVideo => 'Fusionner des vidéos';

  @override
  String get selectTwoVideosToMerge => 'Sélectionnez deux vidéos à fusionner';

  @override
  String get video1 => 'Vidéo 1';

  @override
  String get video2 => 'Vidéo 2';

  @override
  String get selectVideo1 => 'Sélectionner la vidéo 1';

  @override
  String get selectVideo2 => 'Sélectionner la vidéo 2';

  @override
  String get pleaseSelectTwoVideos => 'Veuillez d\'abord sélectionner deux vidéos';

  @override
  String get webNotSupportMerge => 'La fusion n\'est pas prise en charge sur le Web';

  @override
  String get video1CropFailed => 'Échec du rognage de la vidéo 1';

  @override
  String get video2CropFailed => 'Échec du rognage de la vidéo 2';

  @override
  String get mergeSuccess => 'Fusion réussie !';

  @override
  String get mergeFailed => 'Échec de la fusion';

  @override
  String mergeError(String error) {
    return 'Erreur de fusion : $error';
  }

  @override
  String get merging => 'Fusion en cours...';

  @override
  String get startMerge => 'Démarrer la fusion';

  @override
  String get compressVideo => 'Compresser la vidéo';

  @override
  String get compressSuccess => 'Compression terminée !';

  @override
  String get compressFailed => 'Échec de la compression';

  @override
  String compressError(String error) {
    return 'Erreur de compression : $error';
  }

  @override
  String originalSize(String size) {
    return 'Taille originale : $size';
  }

  @override
  String compressQuality(int value) {
    return 'Qualité de compression (CRF) : $value';
  }

  @override
  String get compressTip => 'Une valeur plus élevée signifie plus de compression, moins de qualité';

  @override
  String get encodeSpeed => 'Vitesse d\'encodage :';

  @override
  String compressedSize(String size) {
    return 'Compressé : $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Économisé : $size ($percent%)';
  }

  @override
  String get compressing => 'Compression en cours...';

  @override
  String get startCompress => 'Démarrer la compression';

  @override
  String get convertFormat => 'Convertir le format';

  @override
  String get convertSuccess => 'Conversion réussie !';

  @override
  String get convertFailed => 'Échec de la conversion';

  @override
  String convertError(String error) {
    return 'Erreur de conversion : $error';
  }

  @override
  String get targetFormat => 'Format cible :';

  @override
  String get converting => 'Conversion en cours...';

  @override
  String convertTo(String format) {
    return 'Convertir en $format';
  }

  @override
  String get cropVideo => 'Rogner la vidéo';

  @override
  String get cropSuccess => 'Rognage réussi !';

  @override
  String get cropFailed => 'Échec du rognage';

  @override
  String cropError(String error) {
    return 'Erreur de rognage : $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'Échec de la prévisualisation, mais le fichier a été généré';

  @override
  String originalResolution(int width, int height) {
    return 'Original : ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Rognage : ${width}x$height';
  }

  @override
  String get cropDragTip => 'Faites glisser le cadre vert ou les bords pour ajuster la zone de rognage, glissez à l\'intérieur pour déplacer';

  @override
  String get resetCrop => 'Réinitialiser la zone de rognage';

  @override
  String get cropping => 'Rognage en cours...';

  @override
  String get startCrop => 'Démarrer le rognage';

  @override
  String get cutVideo => 'Couper la vidéo';

  @override
  String get cutSuccess => 'Coupe réussie !';

  @override
  String get cutFailed => 'Échec de la coupe';

  @override
  String cutError(String error) {
    return 'Erreur de coupe : $error';
  }

  @override
  String get cutCompletePreviewUnavailable => 'Coupe terminée (prévisualisation indisponible)';

  @override
  String get videoPreviewUnavailable => 'Prévisualisation vidéo indisponible';

  @override
  String totalDuration(String duration) {
    return 'Durée totale : $duration';
  }

  @override
  String cutRange(String start, String end, String duration) {
    return 'Coupe : $start - $end  ($duration)';
  }

  @override
  String get cutting => 'Coupe en cours...';

  @override
  String get startCut => 'Démarrer la coupe';

  @override
  String get dubbingVideo => 'Doublage vidéo';

  @override
  String get dubbingSuccess => 'Doublage réussi !';

  @override
  String get dubbingFailed => 'Échec du doublage';

  @override
  String dubbingError(String error) {
    return 'Erreur de doublage : $error';
  }

  @override
  String get selectVideo => 'Sélectionner la vidéo';

  @override
  String get videoSelected => 'Vidéo sélectionnée';

  @override
  String get selectAudio => 'Sélectionner l\'audio';

  @override
  String get audioSelected => 'Audio sélectionné';

  @override
  String get dubbingMode => 'Mode de doublage :';

  @override
  String get replaceOriginalAudio => 'Remplacer l\'audio original';

  @override
  String get replaceAudioHint => 'Désactivez pour mixer les deux pistes audio';

  @override
  String get dubbing => 'Doublage en cours...';

  @override
  String get startDubbing => 'Démarrer le doublage';

  @override
  String get startOver => 'Recommencer';

  @override
  String get extractImages => 'Extraire des images';

  @override
  String get startTimeMustBeBeforeEnd => 'L\'heure de début doit être antérieure à l\'heure de fin';

  @override
  String extractedCount(int count) {
    return '$count images extraites';
  }

  @override
  String get noImagesExtracted => 'Aucune image extraite, veuillez vérifier le fichier vidéo';

  @override
  String get extractFailed => 'Échec de l\'extraction';

  @override
  String extractError(String error) {
    return 'Erreur d\'extraction : $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return '$count images sauvegardées dans l\'album';
  }

  @override
  String videoDuration(String duration) {
    return 'Durée de la vidéo : $duration';
  }

  @override
  String get startTime => 'Heure de début';

  @override
  String get endTime => 'Heure de fin';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Plage d\'extraction : $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Taux d\'extraction : $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return 'Environ $count images seront extraites';
  }

  @override
  String get extracting => 'Extraction en cours...';

  @override
  String get startExtract => 'Démarrer l\'extraction';

  @override
  String extractedImagesCount(int count) {
    return '$count images extraites';
  }

  @override
  String showingFirst30(int count) {
    return 'Affichage des 30 premières sur $count';
  }

  @override
  String saveAllCount(int count) {
    return 'Sauvegarder tout $count';
  }

  @override
  String get muteVideo => 'Rendre muet';

  @override
  String get muteSuccess => 'Son supprimé avec succès !';

  @override
  String get muteFailed => 'Échec de la suppression du son';

  @override
  String muteError(String error) {
    return 'Erreur de suppression du son : $error';
  }

  @override
  String get muteDescription => 'Tout l\'audio sera supprimé, seules les images vidéo seront conservées';

  @override
  String get muting => 'Suppression du son en cours...';

  @override
  String get removeAudio => 'Supprimer l\'audio';

  @override
  String get ratioVideo => 'Ratio vidéo';

  @override
  String get ratioSuccess => 'Ratio ajusté avec succès !';

  @override
  String get ratioFailed => 'Échec de l\'ajustement du ratio';

  @override
  String ratioError(String error) {
    return 'Erreur de ratio : $error';
  }

  @override
  String get targetRatio => 'Ratio cible :';

  @override
  String get scaleMode => 'Mode de mise à l\'échelle :';

  @override
  String get stretchFit => 'Étirement';

  @override
  String get cropFill => 'Remplissage avec rognage';

  @override
  String get letterbox => 'Bandes noires';

  @override
  String get adjusting => 'Ajustement en cours...';

  @override
  String get startAdjust => 'Démarrer l\'ajustement';

  @override
  String get separateAV => 'Séparer A/V';

  @override
  String get separateComplete => 'Séparation terminée !';

  @override
  String get separateFailed => 'Échec de la séparation, la vidéo peut ne pas contenir de pistes audio/vidéo';

  @override
  String separateError(String error) {
    return 'Erreur de séparation : $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Vidéo seule sauvegardée dans l\'album';

  @override
  String get saveVideoFailed => 'Échec de la sauvegarde de la vidéo';

  @override
  String saveVideoError(String error) {
    return 'Erreur de sauvegarde vidéo : $error';
  }

  @override
  String get cannotGetDownloadDir => 'Impossible d\'obtenir le répertoire de téléchargement';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label sauvegardé dans : Téléchargements/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return 'Le fichier $label n\'existe pas';
  }

  @override
  String get separateDescription => 'Extraire les images vidéo et l\'audio en fichiers séparés';

  @override
  String get separating => 'Séparation en cours...';

  @override
  String get startSeparate => 'Démarrer la séparation';

  @override
  String get videoOnly => 'Vidéo seule (sans audio)';

  @override
  String get savedToAlbumLabel => 'Sauvegardé dans l\'album';

  @override
  String get m4aAudio => 'Audio M4A';

  @override
  String get mp3Audio => 'Audio MP3';

  @override
  String get savedToDownloadsShort => 'Sauvegardé dans Téléchargements';

  @override
  String get playMp3Audio => 'Lire l\'audio MP3';

  @override
  String get playM4aAudio => 'Lire l\'audio M4A';

  @override
  String get splitVideo => 'Diviser la vidéo';

  @override
  String get addAtLeastOneSplitPoint => 'Veuillez ajouter au moins un point de division';

  @override
  String splitComplete(int count) {
    return 'Division terminée ! $count segments';
  }

  @override
  String get splitFailed => 'Échec de la division';

  @override
  String splitError(String error) {
    return 'Erreur de division : $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return '$count segments sauvegardés dans l\'album';
  }

  @override
  String get splitPoints => 'Points de division :';

  @override
  String get add => 'Ajouter';

  @override
  String get noSplitPoints => 'Aucun point de division, appuyez pour ajouter';

  @override
  String splitPoint(int index) {
    return 'Point de division $index :';
  }

  @override
  String willProduceSegments(int count) {
    return 'Produira $count segments après la division :';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Segment $index : $start-$end ($duration)';
  }

  @override
  String get splitting => 'Division en cours...';

  @override
  String get startSplit => 'Démarrer la division';

  @override
  String saveAllSegments(int count) {
    return 'Sauvegarder tous les $count segments';
  }

  @override
  String segment(int index) {
    return 'Segment $index';
  }

  @override
  String get privacyTitle => 'Politique de confidentialité';

  @override
  String get updateDate => 'Date de mise à jour';

  @override
  String get privacyDate => '1er janvier 2025';

  @override
  String get section1Title => '1. Collecte d\'informations';

  @override
  String get section1Content => 'Nous prenons votre vie privée très au sérieux. Cette application ne collecte que les informations nécessaires suivantes lors de la prestation de services :';

  @override
  String get section1Item1 => 'Fichiers vidéo/audio que vous sélectionnez activement (uniquement utilisés pour le traitement local, jamais téléchargés vers un serveur)';

  @override
  String get section1Item2 => 'Informations de base sur l\'appareil (pour l\'adaptation de l\'appareil, ne contient pas d\'informations d\'identité personnelle)';

  @override
  String get section2Title => '2. Utilisation des informations';

  @override
  String get section2Content => 'Tout le traitement audio/vidéo est effectué localement sur votre appareil. Nous ne téléchargerons jamais vos fichiers ou données vers des serveurs distants. Les informations collectées sur l\'appareil sont uniquement utilisées pour l\'adaptation des fonctionnalités et l\'investigation des plantages.';

  @override
  String get section3Title => '3. Stockage des informations';

  @override
  String get section3Content => 'Les fichiers temporaires générés par l\'application sont stockés dans le répertoire temporaire local de l\'appareil. Vous pouvez les sauvegarder ou les supprimer à votre guise après le traitement. Nous ne stockons aucune de vos données sur des serveurs.';

  @override
  String get section4Title => '4. Partage des informations';

  @override
  String get section4Content => 'Nous ne vendrons, n\'échangerons ni ne transférerons vos informations personnelles à des tiers, sauf dans les cas suivants :';

  @override
  String get section4Item1 => 'Avec votre consentement explicite';

  @override
  String get section4Item2 => 'Conformément à la loi ou à une ordonnance gouvernementale';

  @override
  String get section5Title => '5. Services tiers';

  @override
  String get section5Content => 'Cette application utilise certains SDK tiers pour fournir des services, qui peuvent avoir leurs propres politiques de confidentialité. Veuillez consulter la page « Liste des SDK tiers » pour plus de détails.';

  @override
  String get section6Title => '6. Sécurité des données';

  @override
  String get section6Content => 'Nous prenons des mesures de sécurité raisonnables pour protéger vos informations contre tout accès, utilisation ou divulgation non autorisés. Cependant, veuillez noter qu\'Internet n\'est pas absolument sûr. Nous vous recommandons de garder votre appareil en sécurité.';

  @override
  String get section7Title => '7. Protection des mineurs';

  @override
  String get section7Content => 'Nous attachons une grande importance à la protection des informations personnelles des mineurs. Si vous avez moins de 18 ans, nous vous recommandons d\'utiliser cette application sous la direction d\'un tuteur.';

  @override
  String get section8Title => '8. Modifications de la politique de confidentialité';

  @override
  String get section8Content => 'Nous pouvons réviser cette politique de confidentialité de temps à autre. En cas de changement, nous vous informerons via des pop-ups ou des annonces dans l\'application.';

  @override
  String get section9Title => '9. Nous contacter';

  @override
  String get section9Content => 'Si vous avez des questions ou des suggestions concernant cette politique de confidentialité, veuillez nous contacter à :\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'Framework de développement d\'applications multiplateformes pour la construction d\'interfaces et d\'interactions';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => 'Bibliothèque principale de traitement audio/vidéo pour le rognage, la compression, la conversion de format, etc.';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => 'Composant de lecture vidéo pour la prévisualisation';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc => 'Sélecteur de fichiers pour choisir des fichiers vidéo et audio locaux';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc => 'Outil de sauvegarde dans l\'album pour enregistrer les fichiers traités dans l\'album système';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc => 'Composant de gestion des permissions pour demander les permissions de stockage, d\'album, etc.';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc => 'Fournisseur de chemin pour obtenir les répertoires temporaires et de documents';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'Bibliothèque de gestion d\'état pour le partage et la gestion de l\'état dans l\'application';

  @override
  String licenseLabel(String license) {
    return 'Licence : $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Échec de l\'initialisation de la vidéo : $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Échec de la sélection de la vidéo : $error';
  }

  @override
  String get premiumVersion => 'Premium';

  @override
  String get alreadyPremium => 'Vous êtes déjà un utilisateur Premium !';

  @override
  String get alreadyPremiumDesc => 'Merci pour votre soutien, toutes les fonctionnalités sont débloquées';

  @override
  String get unlockPremium => 'Débloquer Premium';

  @override
  String get unlockPremiumDesc => 'Achat unique, accès permanent à toutes les fonctionnalités';

  @override
  String get featureUnlimitedSave => 'Sauvegardes illimitées dans l\'album';

  @override
  String get featureUnlimitedTools => 'Utilisation illimitée de tous les outils';

  @override
  String get featureFreeUpdates => 'Mises à jour futures gratuites';

  @override
  String get featureNoAds => 'Expérience sans publicité';

  @override
  String get unlockNow => 'Débloquer maintenant';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get video1LoadFailed => 'Échec du chargement de la vidéo 1';

  @override
  String get video2LoadFailed => 'Échec du chargement de la vidéo 2';

  @override
  String get selectVideoLabel => 'Sélectionner la vidéo';

  @override
  String get videoChanged => 'Changer la vidéo';

  @override
  String get saveVideoOnly => 'Sauvegarder la vidéo seule';

  @override
  String get videoOnlySaved => 'Vidéo seule sauvegardée';

  @override
  String get sourceFileNotExist => 'Le fichier source n\'existe pas';

  @override
  String saveLabel(String label) {
    return 'Sauvegarder $label';
  }

  @override
  String labelSaved(String label) {
    return '$label sauvegardé';
  }

  @override
  String saveLabelError(String error) {
    return 'Erreur de sauvegarde : $error';
  }

  @override
  String get noImagesExtractedShort => 'Aucune image extraite';

  @override
  String get reMerge => 'Re-fusionner';

  @override
  String get originalLabel => 'Original :';

  @override
  String get segmentCount => 'segments';
}
