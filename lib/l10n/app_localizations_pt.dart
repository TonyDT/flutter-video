import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'ToolKit';

  @override
  String get tabAll => 'Todos';

  @override
  String get tabSettings => 'Configurações';

  @override
  String get settingsAbout => 'Configurações & Sobre';

  @override
  String get appearance => 'Aparência';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get autoMode => 'Auto (17h)';

  @override
  String get aboutApp => 'Sobre o app';

  @override
  String get appNameLabel => 'Nome do app';

  @override
  String get versionLabel => 'Versão';

  @override
  String get developerLabel => 'Desenvolvedor';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get viewPrivacyTerms => 'Ver termos de privacidade';

  @override
  String get sdkList => 'Lista de SDKs de terceiros';

  @override
  String get viewThirdPartyServices => 'Ver serviços de terceiros';

  @override
  String get iapDescription => 'Compra no app';

  @override
  String get viewIapDetails => 'Ver detalhes de compra e assinatura';

  @override
  String get iapSection1Title => '1. Itens de compra no app';

  @override
  String get iapSection1Content => 'Este app oferece uma compra no app \"Premium\", que é uma compra única, não uma assinatura de renovação automática. Após a compra, você desbloqueará permanentemente todos os recursos, incluindo: salvamentos ilimitados no álbum, uso irrestrito de todas as ferramentas, atualizações futuras gratuitas e experiência sem anúncios.';

  @override
  String get iapSection2Title => '2. Pagamento e confirmação';

  @override
  String get iapSection2Content => 'A compra será cobrada na sua conta Apple ID / Google Play. Após a confirmação, o valor será deduzido da sua conta.';

  @override
  String get iapSection3Title => '3. Restaurar compras';

  @override
  String get iapSection3Content => 'Se você trocar de dispositivo ou reinstalar o app, toque em \"Restaurar compras\" na página de Configurações ou Loja para restaurar seu acesso Premium gratuitamente, sem pagar novamente.';

  @override
  String get iapSection4Title => '4. Cancelamento e reembolso';

  @override
  String get iapSection4Content => 'Esta é uma compra única. Reembolsos não são suportados após a compra. Se precisar de reembolso, solicite pelos canais oficiais da Apple / Google Play.';

  @override
  String get iapSection5Title => '5. Entre em contato';

  @override
  String get iapSection5Content => 'Se você tiver dúvidas sobre compras no app, entre em contato:\nxinyoushanhai888@gmail.com';

  @override
  String get welcomeTitle => 'Bem-vindo ao ToolKit';

  @override
  String welcomeFreeCount(int count) {
    return 'Você tem $count usos gratuitos. Cada salvamento no álbum consome 1 uso.';
  }

  @override
  String get welcomeUpgradeHint => 'Atualize para Premium para acesso ilimitado a todos os recursos';

  @override
  String get welcomeGotIt => 'Entendi';

  @override
  String get welcomeUpgrade => 'Atualizar para Premium';

  @override
  String freeCountRemaining(int count) {
    return '$count restantes';
  }

  @override
  String get freeCountExhausted => 'Usos gratuitos esgotados';

  @override
  String get upgradeToUnlock => 'Atualize para Premium para uso ilimitado';

  @override
  String get openSourceNotice => 'Construído com FFmpeg, Flutter e outras tecnologias de código aberto. Obrigado à comunidade open-source.';

  @override
  String get harmonyDeveloping => 'Versão HarmonyOS em desenvolvimento';

  @override
  String get language => 'Idioma';

  @override
  String get toolMerge => 'Mesclar vídeos';

  @override
  String get toolMergeDesc => 'Mesclar vários arquivos de vídeo em um';

  @override
  String get toolCut => 'Cortar vídeo';

  @override
  String get toolCutDesc => 'Extrair um segmento de tempo específico do vídeo';

  @override
  String get toolCompress => 'Comprimir vídeo';

  @override
  String get toolCompressDesc => 'Reduzir o tamanho do arquivo de vídeo';

  @override
  String get toolRatio => 'Proporção do vídeo';

  @override
  String get toolRatioDesc => 'Ajustar proporção de aspecto';

  @override
  String get toolMute => 'Silenciar vídeo';

  @override
  String get toolMuteDesc => 'Remover faixa de áudio do vídeo';

  @override
  String get toolDubbing => 'Dublar vídeo';

  @override
  String get toolDubbingDesc => 'Adicionar música de fundo ao vídeo';

  @override
  String get toolExtract => 'Extrair imagens';

  @override
  String get toolExtractDesc => 'Extrair quadros do vídeo como imagens';

  @override
  String get toolSplit => 'Dividir vídeo';

  @override
  String get toolSplitDesc => 'Dividir vídeo em vários segmentos';

  @override
  String get toolSeparate => 'Separar A/V';

  @override
  String get toolSeparateDesc => 'Separar faixas de áudio e vídeo';

  @override
  String get toolCrop => 'Recortar vídeo';

  @override
  String get toolCropDesc => 'Recortar área do quadro do vídeo';

  @override
  String get toolConvert => 'Converter formato';

  @override
  String get toolConvertDesc => 'Converter formato do arquivo de vídeo';

  @override
  String toolCountAll(int count) {
    return '$count ferramentas · Todas';
  }

  @override
  String featureDeveloping(String name) {
    return '$name está em desenvolvimento';
  }

  @override
  String get selectVideoFailed => 'Falha ao selecionar vídeo';

  @override
  String get selectAudioFailed => 'Falha ao selecionar áudio';

  @override
  String get needAlbumPermission => 'Permissão de álbum necessária';

  @override
  String get savedToAlbum => 'Salvo no álbum';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String saveError(String error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get loading => 'Carregando...';

  @override
  String get tapToSelectVideo => 'Toque para selecionar um vídeo';

  @override
  String get tapToSelectFirstVideo => 'Selecionar primeiro vídeo';

  @override
  String get tapToSelectSecondVideo => 'Selecionar segundo vídeo';

  @override
  String get tapToPreview => 'Toque para visualizar';

  @override
  String get start => 'Início';

  @override
  String get end => 'Fim';

  @override
  String get change => 'Alterar';

  @override
  String get reselect => 'Resselecionar';

  @override
  String get changeVideo => 'Alterar vídeo';

  @override
  String get saveToAlbum => 'Salvar no álbum';

  @override
  String get processing => 'Processando...';

  @override
  String get videoLoadFailed => 'Falha ao carregar vídeo';

  @override
  String get previewFailed => 'Falha na visualização';

  @override
  String get previewInitFailed => 'Falha na inicialização da visualização';

  @override
  String get mergeVideo => 'Mesclar vídeos';

  @override
  String get selectTwoVideosToMerge => 'Selecione dois vídeos para mesclar';

  @override
  String get video1 => 'Vídeo 1';

  @override
  String get video2 => 'Vídeo 2';

  @override
  String get selectVideo1 => 'Selecionar vídeo 1';

  @override
  String get selectVideo2 => 'Selecionar vídeo 2';

  @override
  String get pleaseSelectTwoVideos => 'Por favor, selecione dois vídeos primeiro';

  @override
  String get webNotSupportMerge => 'Mesclagem não é suportada na Web';

  @override
  String get video1CropFailed => 'Falha ao recortar vídeo 1';

  @override
  String get video2CropFailed => 'Falha ao recortar vídeo 2';

  @override
  String get mergeSuccess => 'Mesclagem bem-sucedida!';

  @override
  String get mergeFailed => 'Falha na mesclagem';

  @override
  String mergeError(String error) {
    return 'Erro na mesclagem: $error';
  }

  @override
  String get merging => 'Mesclando...';

  @override
  String get startMerge => 'Iniciar mesclagem';

  @override
  String get compressVideo => 'Comprimir vídeo';

  @override
  String get compressSuccess => 'Compressão concluída!';

  @override
  String get compressFailed => 'Falha na compressão';

  @override
  String compressError(String error) {
    return 'Erro de compressão: $error';
  }

  @override
  String originalSize(String size) {
    return 'Tamanho original: $size';
  }

  @override
  String compressQuality(int value) {
    return 'Qualidade de compressão (CRF): $value';
  }

  @override
  String get compressTip => 'Valor mais alto significa mais compressão, menor qualidade';

  @override
  String get encodeSpeed => 'Velocidade de codificação:';

  @override
  String compressedSize(String size) {
    return 'Comprimido: $size';
  }

  @override
  String savedSpace(String size, String percent) {
    return 'Economizado: $size ($percent%)';
  }

  @override
  String get compressing => 'Comprimindo...';

  @override
  String get startCompress => 'Iniciar compressão';

  @override
  String get convertFormat => 'Converter formato';

  @override
  String get convertSuccess => 'Conversão bem-sucedida!';

  @override
  String get convertFailed => 'Falha na conversão';

  @override
  String convertError(String error) {
    return 'Erro de conversão: $error';
  }

  @override
  String get targetFormat => 'Formato de destino:';

  @override
  String get converting => 'Convertendo...';

  @override
  String convertTo(String format) {
    return 'Converter para $format';
  }

  @override
  String get cropVideo => 'Recortar vídeo';

  @override
  String get cropSuccess => 'Recorte bem-sucedido!';

  @override
  String get cropFailed => 'Falha no recorte';

  @override
  String cropError(String error) {
    return 'Erro de recorte: $error';
  }

  @override
  String get cropPreviewFailedButSaved => 'Falha na visualização, mas o arquivo foi gerado';

  @override
  String originalResolution(int width, int height) {
    return 'Original: ${width}x$height';
  }

  @override
  String cropResolution(int width, int height) {
    return 'Recorte: ${width}x$height';
  }

  @override
  String get cropDragTip => 'Arraste a caixa verde ou bordas para ajustar a área de recorte, arraste dentro para mover';

  @override
  String get resetCrop => 'Redefinir área de recorte';

  @override
  String get cropping => 'Recortando...';

  @override
  String get startCrop => 'Iniciar recorte';

  @override
  String get cutVideo => 'Cortar vídeo';

  @override
  String get cutSuccess => 'Corte bem-sucedido!';

  @override
  String get cutFailed => 'Falha no corte';

  @override
  String cutError(String error) {
    return 'Erro de corte: $error';
  }

  @override
  String get cutCompletePreviewUnavailable => 'Corte concluído (visualização indisponível)';

  @override
  String get videoPreviewUnavailable => 'Visualização de vídeo indisponível';

  @override
  String totalDuration(String duration) {
    return 'Duração total: $duration';
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
  String get dubbingVideo => 'Dublar vídeo';

  @override
  String get dubbingSuccess => 'Dublagem bem-sucedida!';

  @override
  String get dubbingFailed => 'Falha na dublagem';

  @override
  String dubbingError(String error) {
    return 'Erro de dublagem: $error';
  }

  @override
  String get selectVideo => 'Selecionar vídeo';

  @override
  String get videoSelected => 'Vídeo selecionado';

  @override
  String get selectAudio => 'Selecionar áudio';

  @override
  String get audioSelected => 'Áudio selecionado';

  @override
  String get dubbingMode => 'Modo de dublagem:';

  @override
  String get replaceOriginalAudio => 'Substituir áudio original';

  @override
  String get replaceAudioHint => 'Desative para misturar ambas as faixas de áudio';

  @override
  String get dubbing => 'Dublando...';

  @override
  String get startDubbing => 'Iniciar dublagem';

  @override
  String get startOver => 'Recomeçar';

  @override
  String get extractImages => 'Extrair imagens';

  @override
  String get startTimeMustBeBeforeEnd => 'O horário de início deve ser anterior ao horário de fim';

  @override
  String extractedCount(int count) {
    return '$count imagens extraídas';
  }

  @override
  String get noImagesExtracted => 'Nenhuma imagem extraída, verifique o arquivo de vídeo';

  @override
  String get extractFailed => 'Falha na extração';

  @override
  String extractError(String error) {
    return 'Erro de extração: $error';
  }

  @override
  String savedCountToAlbum(int count) {
    return '$count imagens salvas no álbum';
  }

  @override
  String videoDuration(String duration) {
    return 'Duração do vídeo: $duration';
  }

  @override
  String get startTime => 'Horário de início';

  @override
  String get endTime => 'Horário de fim';

  @override
  String extractRange(String start, String end, String duration) {
    return 'Intervalo de extração: $start - $end  ($duration)';
  }

  @override
  String extractFps(String fps) {
    return 'Taxa de extração: $fps fps';
  }

  @override
  String estimatedImages(int count) {
    return 'Cerca de $count imagens serão extraídas';
  }

  @override
  String get extracting => 'Extraindo...';

  @override
  String get startExtract => 'Iniciar extração';

  @override
  String extractedImagesCount(int count) {
    return '$count imagens extraídas';
  }

  @override
  String showingFirst30(int count) {
    return 'Mostrando as 30 primeiras de $count';
  }

  @override
  String saveAllCount(int count) {
    return 'Salvar todas $count';
  }

  @override
  String get muteVideo => 'Silenciar vídeo';

  @override
  String get muteSuccess => 'Vídeo silenciado com sucesso!';

  @override
  String get muteFailed => 'Falha ao silenciar';

  @override
  String muteError(String error) {
    return 'Erro ao silenciar: $error';
  }

  @override
  String get muteDescription => 'Todo o áudio será removido, apenas os quadros de vídeo serão mantidos';

  @override
  String get muting => 'Silenciando...';

  @override
  String get removeAudio => 'Remover áudio';

  @override
  String get ratioVideo => 'Proporção do vídeo';

  @override
  String get ratioSuccess => 'Proporção ajustada com sucesso!';

  @override
  String get ratioFailed => 'Falha no ajuste da proporção';

  @override
  String ratioError(String error) {
    return 'Erro de proporção: $error';
  }

  @override
  String get targetRatio => 'Proporção de destino:';

  @override
  String get scaleMode => 'Modo de escala:';

  @override
  String get stretchFit => 'Esticar';

  @override
  String get cropFill => 'Preencher com recorte';

  @override
  String get letterbox => 'Faixas pretas';

  @override
  String get adjusting => 'Ajustando...';

  @override
  String get startAdjust => 'Iniciar ajuste';

  @override
  String get separateAV => 'Separar A/V';

  @override
  String get separateComplete => 'Separação concluída!';

  @override
  String get separateFailed => 'Falha na separação, o vídeo pode não conter faixas de áudio/vídeo';

  @override
  String separateError(String error) {
    return 'Erro de separação: $error';
  }

  @override
  String get videoOnlySavedToAlbum => 'Apenas vídeo salvo no álbum';

  @override
  String get saveVideoFailed => 'Falha ao salvar vídeo';

  @override
  String saveVideoError(String error) {
    return 'Erro ao salvar vídeo: $error';
  }

  @override
  String get cannotGetDownloadDir => 'Não é possível obter o diretório de downloads';

  @override
  String savedToDownloads(String label, String fileName) {
    return '$label salvo em: Downloads/$fileName';
  }

  @override
  String fileNotExist(String label) {
    return 'Arquivo $label não existe';
  }

  @override
  String get separateDescription => 'Extrair quadros de vídeo e áudio como arquivos separados';

  @override
  String get separating => 'Separando...';

  @override
  String get startSeparate => 'Iniciar separação';

  @override
  String get videoOnly => 'Apenas vídeo (sem áudio)';

  @override
  String get savedToAlbumLabel => 'Salvo no álbum';

  @override
  String get m4aAudio => 'Áudio M4A';

  @override
  String get mp3Audio => 'Áudio MP3';

  @override
  String get savedToDownloadsShort => 'Salvo nos Downloads';

  @override
  String get playMp3Audio => 'Reproduzir áudio MP3';

  @override
  String get playM4aAudio => 'Reproduzir áudio M4A';

  @override
  String get splitVideo => 'Dividir vídeo';

  @override
  String get addAtLeastOneSplitPoint => 'Adicione pelo menos um ponto de divisão';

  @override
  String splitComplete(int count) {
    return 'Divisão concluída! $count segmentos';
  }

  @override
  String get splitFailed => 'Falha na divisão';

  @override
  String splitError(String error) {
    return 'Erro de divisão: $error';
  }

  @override
  String savedSegmentsToAlbum(int count) {
    return '$count segmentos salvos no álbum';
  }

  @override
  String get splitPoints => 'Pontos de divisão:';

  @override
  String get add => 'Adicionar';

  @override
  String get noSplitPoints => 'Sem pontos de divisão, toque para adicionar';

  @override
  String splitPoint(int index) {
    return 'Ponto de divisão $index:';
  }

  @override
  String willProduceSegments(int count) {
    return 'Produzirá $count segmentos após a divisão:';
  }

  @override
  String segmentInfo(int index, String start, String end, String duration) {
    return 'Segmento $index: $start-$end ($duration)';
  }

  @override
  String get splitting => 'Dividindo...';

  @override
  String get startSplit => 'Iniciar divisão';

  @override
  String saveAllSegments(int count) {
    return 'Salvar todos os $count segmentos';
  }

  @override
  String segment(int index) {
    return 'Segmento $index';
  }

  @override
  String get privacyTitle => 'Política de Privacidade';

  @override
  String get updateDate => 'Data de atualização';

  @override
  String get privacyDate => '1 de janeiro de 2025';

  @override
  String get section1Title => '1. Coleta de informações';

  @override
  String get section1Content => 'Levamos sua privacidade muito a sério. Este app coleta apenas as seguintes informações necessárias durante a prestação de serviços:';

  @override
  String get section1Item1 => 'Arquivos de vídeo/áudio que você seleciona ativamente (usados apenas para processamento local, nunca enviados a nenhum servidor)';

  @override
  String get section1Item2 => 'Informações básicas do dispositivo (para adaptação do dispositivo, não contém informações de identidade pessoal)';

  @override
  String get section2Title => '2. Uso das informações';

  @override
  String get section2Content => 'Todo o processamento de áudio/vídeo é concluído localmente no seu dispositivo. Nunca enviaremos seus arquivos ou dados para servidores remotos. As informações do dispositivo coletadas são usadas apenas para adaptação de recursos e investigação de falhas.';

  @override
  String get section3Title => '3. Armazenamento de informações';

  @override
  String get section3Content => 'Arquivos temporários gerados pelo app são armazenados no diretório temporário local do dispositivo. Você pode salvá-los ou excluí-los a seu critério após o processamento. Não armazenamos nenhum dos seus dados em servidores.';

  @override
  String get section4Title => '4. Compartilhamento de informações';

  @override
  String get section4Content => 'Não venderemos, trocaremos ou transferiremos suas informações pessoais a terceiros, exceto nos seguintes casos:';

  @override
  String get section4Item1 => 'Com seu consentimento explícito';

  @override
  String get section4Item2 => 'Conforme exigido por lei ou ordem governamental';

  @override
  String get section5Title => '5. Serviços de terceiros';

  @override
  String get section5Content => 'Este app usa alguns SDKs de terceiros para fornecer serviços, que podem ter suas próprias políticas de privacidade. Consulte a página \"Lista de SDKs de terceiros\" para detalhes.';

  @override
  String get section6Title => '6. Segurança de dados';

  @override
  String get section6Content => 'Tomamos medidas de segurança razoáveis para proteger suas informações contra acesso, uso ou divulgação não autorizados. No entanto, observe que a Internet não é absolutamente segura. Recomendamos manter seu dispositivo seguro.';

  @override
  String get section7Title => '7. Proteção de menores';

  @override
  String get section7Content => 'Damos grande importância à proteção de informações pessoais de menores. Se você tem menos de 18 anos, recomendamos usar este app sob a orientação de um responsável.';

  @override
  String get section8Title => '8. Alterações na política de privacidade';

  @override
  String get section8Content => 'Podemos revisar esta política de privacidade periodicamente. Quando houver alterações, notificaremos você por pop-ups no app ou anúncios.';

  @override
  String get section9Title => '9. Entre em contato';

  @override
  String get section9Content => 'Se você tiver dúvidas ou sugestões sobre esta política de privacidade, entre em contato:\nxinyoushanhai888@gmail.com';

  @override
  String get sdkFlutterTitle => 'Flutter';

  @override
  String get sdkFlutterDesc => 'Framework de desenvolvimento de aplicativos multiplataforma para construção de UI e interações';

  @override
  String get sdkFfmpegTitle => 'FFmpeg';

  @override
  String get sdkFfmpegDesc => 'Biblioteca principal de processamento de áudio/vídeo para corte, compressão, conversão de formato etc.';

  @override
  String get sdkVideoPlayerTitle => 'Video Player';

  @override
  String get sdkVideoPlayerDesc => 'Componente de reprodução de vídeo para visualização';

  @override
  String get sdkFilePickerTitle => 'File Picker';

  @override
  String get sdkFilePickerDesc => 'Seletor de arquivos para escolher vídeos e áudios locais';

  @override
  String get sdkGallerySaverTitle => 'Gallery Saver';

  @override
  String get sdkGallerySaverDesc => 'Ferramenta de salvamento no álbum para salvar arquivos processados no álbum do sistema';

  @override
  String get sdkPermissionTitle => 'Permission Handler';

  @override
  String get sdkPermissionDesc => 'Componente de gerenciamento de permissões para solicitar armazenamento, álbum e outras permissões do sistema';

  @override
  String get sdkPathProviderTitle => 'Path Provider';

  @override
  String get sdkPathProviderDesc => 'Provedor de caminho para obter diretórios temporários e de documentos';

  @override
  String get sdkProviderTitle => 'Provider';

  @override
  String get sdkProviderDesc => 'Biblioteca de gerenciamento de estado para compartilhamento e gerenciamento de estado no app';

  @override
  String licenseLabel(String license) {
    return 'Licença: $license';
  }

  @override
  String videoInitFailed(String error) {
    return 'Falha na inicialização do vídeo: $error';
  }

  @override
  String selectVideoFailedWithError(String error) {
    return 'Falha ao selecionar vídeo: $error';
  }

  @override
  String get premiumVersion => 'Premium';

  @override
  String get alreadyPremium => 'Você já é um usuário Premium!';

  @override
  String get alreadyPremiumDesc => 'Obrigado pelo seu apoio, todos os recursos estão desbloqueados';

  @override
  String get unlockPremium => 'Desbloquear Premium';

  @override
  String get unlockPremiumDesc => 'Compra única, acesso permanente a todos os recursos';

  @override
  String get featureUnlimitedSave => 'Salvamentos ilimitados no álbum';

  @override
  String get featureUnlimitedTools => 'Uso irrestrito de todas as ferramentas';

  @override
  String get featureFreeUpdates => 'Atualizações futuras gratuitas';

  @override
  String get featureNoAds => 'Experiência sem anúncios';

  @override
  String get unlockNow => 'Desbloquear agora';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get video1LoadFailed => 'Falha ao carregar vídeo 1';

  @override
  String get video2LoadFailed => 'Falha ao carregar vídeo 2';

  @override
  String get selectVideoLabel => 'Selecionar vídeo';

  @override
  String get videoChanged => 'Alterar vídeo';

  @override
  String get saveVideoOnly => 'Salvar apenas vídeo';

  @override
  String get videoOnlySaved => 'Apenas vídeo salvo';

  @override
  String get sourceFileNotExist => 'Arquivo fonte não existe';

  @override
  String saveLabel(String label) {
    return 'Salvar $label';
  }

  @override
  String labelSaved(String label) {
    return '$label salvo';
  }

  @override
  String saveLabelError(String error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get noImagesExtractedShort => 'Nenhuma imagem extraída';

  @override
  String get reMerge => 'Mesclar novamente';

  @override
  String get originalLabel => 'Original:';

  @override
  String get segmentCount => 'segmentos';
}
