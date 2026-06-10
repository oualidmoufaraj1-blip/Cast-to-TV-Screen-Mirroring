import 'package:flutter/material.dart';

typedef _S = Map<String, String>;

class AppStrings {
  AppStrings(this._code);

  final String _code;

  static const supportedLocales = [
    Locale('en'),
    Locale('fr'),
    Locale('es'),
    Locale('ar'),
  ];

  static AppStrings of(Locale locale) => AppStrings(locale.languageCode);

  String _t(_S map) => map[_code] ?? map['en']!;

  // Common
  String get appName => _t({
    'en': 'Cast to TV',
    'fr': 'Cast to TV',
    'es': 'Cast to TV',
    'ar': 'Cast to TV',
  });

  String get screenMirroring => _t({
    'en': 'Screen Mirroring',
    'fr': 'Miroir d’écran',
    'es': 'Duplicación de pantalla',
    'ar': 'انعكاس الشاشة',
  });

  String get connectYourDevice => _t({
    'en': 'Connect your device',
    'fr': 'Connectez votre appareil',
    'es': 'Conecta tu dispositivo',
    'ar': 'اتصل بجهازك',
  });

  String get tapToConnect => _t({
    'en': 'Tap to Connect',
    'fr': 'Touchez pour connecter',
    'es': 'Toca para conectar',
    'ar': 'اضغط للاتصال',
  });

  String get wifiNotice => _t({
    'en': 'Your TV and device must be connected to the same WiFi network',
    'fr':
        'Votre TV et votre appareil doivent être connectés au même réseau Wi-Fi',
    'es': 'Tu TV y tu dispositivo deben estar conectados a la misma red Wi-Fi',
    'ar': 'يجب أن يكون التلفاز والهاتف متصلين بنفس شبكة Wi-Fi',
  });

  String get howItWorks => _t({
    'en': 'How it works',
    'fr': 'Comment ça marche',
    'es': 'Cómo funciona',
    'ar': 'كيف يعمل التطبيق',
  });

  String get photo =>
      _t({'en': 'Photo', 'fr': 'Photo', 'es': 'Foto', 'ar': 'الصور'});

  String get video =>
      _t({'en': 'Video', 'fr': 'Vidéo', 'es': 'Video', 'ar': 'الفيديو'});

  String get browser => _t({
    'en': 'Browser',
    'fr': 'Navigateur',
    'es': 'Navegador',
    'ar': 'المتصفح',
  });

  String get youtube => 'YouTube';
  String get vimeo => 'Vimeo';

  String get remoteControl => _t({
    'en': 'Remote Control',
    'fr': 'Télécommande',
    'es': 'Control remoto',
    'ar': 'التحكم عن بُعد',
  });

  String get settings => _t({
    'en': 'Settings',
    'fr': 'Paramètres',
    'es': 'Ajustes',
    'ar': 'الإعدادات',
  });

  String get language =>
      _t({'en': 'Language', 'fr': 'Langue', 'es': 'Idioma', 'ar': 'اللغة'});

  String get appearance => _t({
    'en': 'Appearance',
    'fr': 'Apparence',
    'es': 'Apariencia',
    'ar': 'المظهر',
  });

  String get vibrateFeedback => _t({
    'en': 'Vibrate Feedback',
    'fr': 'Retour haptique',
    'es': 'Vibración',
    'ar': 'الاهتزاز',
  });

  String get privacyPolicy => _t({
    'en': 'Privacy Policy',
    'fr': 'Politique de confidentialité',
    'es': 'Política de privacidad',
    'ar': 'سياسة الخصوصية',
  });

  String get termsOfUse => _t({
    'en': 'Terms of Use',
    'fr': 'Conditions d’utilisation',
    'es': 'Términos de uso',
    'ar': 'شروط الاستخدام',
  });

  String get contactUs => _t({
    'en': 'Contact Us',
    'fr': 'Contactez-nous',
    'es': 'Contáctanos',
    'ar': 'تواصل معنا',
  });

  String get shareApp => _t({
    'en': 'Share App',
    'fr': 'Partager l’app',
    'es': 'Compartir app',
    'ar': 'مشاركة التطبيق',
  });

  String get version =>
      _t({'en': 'Version', 'fr': 'Version', 'es': 'Versión', 'ar': 'الإصدار'});

  String get giveUsFiveStar => _t({
    'en': 'Give us 5-star',
    'fr': 'Donnez-nous 5 étoiles',
    'es': 'Danos 5 estrellas',
    'ar': 'قيّمنا بـ 5 نجوم',
  });

  String get general =>
      _t({'en': 'General', 'fr': 'Général', 'es': 'General', 'ar': 'عام'});

  String get howToUse => _t({
    'en': 'How to use',
    'fr': 'Comment utiliser',
    'es': 'Cómo usar',
    'ar': 'كيفية الاستخدام',
  });

  String get moreSettings => _t({
    'en': 'More Setting',
    'fr': 'Plus de paramètres',
    'es': 'Más ajustes',
    'ar': 'إعدادات أخرى',
  });

  String get connectToTv => _t({
    'en': 'Connect to TV',
    'fr': 'Connecter à la TV',
    'es': 'Conectar a la TV',
    'ar': 'الاتصال بالتلفاز',
  });

  String get castConnectionGuide => _t({
    'en': 'Cast connection guide',
    'fr': 'Guide de connexion Cast',
    'es': 'Guía de conexión Cast',
    'ar': 'دليل اتصال البث',
  });

  String get screenMirror => _t({
    'en': 'Screen Mirror',
    'fr': 'Miroir d’écran',
    'es': 'Duplicar pantalla',
    'ar': 'انعكاس الشاشة',
  });

  String get mirrorPhoneSubtitle => _t({
    'en': "Mirror phone's screen to TV",
    'fr': 'Dupliquer l’écran du téléphone sur la TV',
    'es': 'Duplica la pantalla del teléfono en la TV',
    'ar': 'اعكس شاشة الهاتف على التلفاز',
  });

  String get tvCast => _t({
    'en': 'TV Cast',
    'fr': 'Diffusion TV',
    'es': 'Transmisión TV',
    'ar': 'بث التلفاز',
  });

  String get helpSubtitle => _t({
    'en': 'Learn how to connect, cast, and mirror your screen',
    'fr': 'Apprenez à connecter, diffuser et dupliquer votre écran',
    'es': 'Aprende a conectar, transmitir y duplicar tu pantalla',
    'ar': 'تعرّف على كيفية الاتصال والبث وانعكاس الشاشة',
  });

  // Appearance options
  String get systemDefault => _t({
    'en': 'System Default',
    'fr': 'Par défaut du système',
    'es': 'Predeterminado del sistema',
    'ar': 'إعداد النظام',
  });

  String get lightMode => _t({
    'en': 'Light Mode',
    'fr': 'Mode clair',
    'es': 'Modo claro',
    'ar': 'الوضع الفاتح',
  });

  String get darkMode => _t({
    'en': 'Dark Mode',
    'fr': 'Mode sombre',
    'es': 'Modo oscuro',
    'ar': 'الوضع الداكن',
  });

  // Onboarding
  String get skip =>
      _t({'en': 'Skip', 'fr': 'Passer', 'es': 'Omitir', 'ar': 'تخطي'});
  String get next =>
      _t({'en': 'Next', 'fr': 'Suivant', 'es': 'Siguiente', 'ar': 'التالي'});
  String get getStarted => _t({
    'en': 'Get Started',
    'fr': 'Commencer',
    'es': 'Empezar',
    'ar': 'ابدأ',
  });

  String get onboarding1Title => _t({
    'en': 'Cast Photos & Videos',
    'fr': 'Diffusez photos et vidéos',
    'es': 'Transmite fotos y videos',
    'ar': 'بث الصور والفيديو',
  });

  String get onboarding1Body => _t({
    'en':
        'Choose photos or videos from your iPhone and use AirPlay to play them on your TV.',
    'fr':
        'Choisissez des photos ou vidéos sur votre iPhone et utilisez AirPlay pour les lire sur votre TV.',
    'es':
        'Elige fotos o videos de tu iPhone y usa AirPlay para reproducirlos en tu TV.',
    'ar':
        'اختر الصور أو الفيديو من هاتفك واستخدم AirPlay لتشغيلها على التلفاز.',
  });

  String get onboarding2Title => connectToTv;
  String get onboarding2Body => _t({
    'en':
        'Make sure your iPhone and TV are connected to the same WiFi network. Your TV must support AirPlay.',
    'fr':
        'Assurez-vous que votre iPhone et votre TV sont sur le même réseau Wi-Fi. Votre TV doit prendre en charge AirPlay.',
    'es':
        'Asegúrate de que tu iPhone y tu TV estén en la misma red Wi-Fi. Tu TV debe ser compatible con AirPlay.',
    'ar':
        'تأكد من أن هاتفك والتلفاز متصلان بنفس شبكة Wi-Fi. يجب أن يدعم التلفاز AirPlay.',
  });

  String get onboarding3Title => screenMirroring;
  String get onboarding3Body => _t({
    'en':
        'Mirror your screen with AirPlay from Control Center, or start Wi‑Fi browser mirroring and open the link on your smart TV.',
    'fr':
        'Miroir d’écran via AirPlay depuis le Centre de contrôle, ou démarrez le miroir navigateur Wi‑Fi et ouvrez le lien sur votre smart TV.',
    'es':
        'Duplica tu pantalla con AirPlay desde el Centro de control, o inicia la duplicación por navegador Wi‑Fi y abre el enlace en tu smart TV.',
    'ar':
        'اعكس شاشتك عبر AirPlay من مركز التحكم، أو ابدأ انعكاس المتصفح عبر Wi‑Fi وافتح الرابط على التلفاز الذكي.',
  });

  // Connect screen
  String get connectSubtitle => _t({
    'en': 'Select an AirPlay-compatible TV, Apple TV, or Mac.',
    'fr': 'Sélectionnez une TV compatible AirPlay, Apple TV ou Mac.',
    'es': 'Selecciona una TV compatible con AirPlay, Apple TV o Mac.',
    'ar': 'اختر تلفازًا متوافقًا مع AirPlay أو Apple TV أو Mac.',
  });

  String get airplayDevicePicker => _t({
    'en': 'AirPlay Device Picker',
    'fr': 'Sélecteur d’appareil AirPlay',
    'es': 'Selector de dispositivo AirPlay',
    'ar': 'محدد جهاز AirPlay',
  });

  String get tapAirplayToChoose => _t({
    'en': 'Tap the AirPlay button to choose a device on your WiFi network.',
    'fr':
        'Touchez le bouton AirPlay pour choisir un appareil sur votre réseau Wi-Fi.',
    'es': 'Toca el botón AirPlay para elegir un dispositivo en tu red Wi-Fi.',
    'ar': 'اضغط زر AirPlay لاختيار جهاز على شبكة Wi-Fi.',
  });

  String get sameWifiNetwork => _t({
    'en': 'Same WiFi network',
    'fr': 'Même réseau Wi-Fi',
    'es': 'Misma red Wi-Fi',
    'ar': 'نفس شبكة Wi-Fi',
  });

  String get sameWifiBody => _t({
    'en': 'Your iPhone and TV must be connected to the same WiFi network.',
    'fr':
        'Votre iPhone et votre TV doivent être connectés au même réseau Wi-Fi.',
    'es': 'Tu iPhone y tu TV deben estar conectados a la misma red Wi-Fi.',
    'ar': 'يجب أن يكون هاتفك والتلفاز متصلين بنفس شبكة Wi-Fi.',
  });

  String get airplayEnabled => _t({
    'en': 'AirPlay enabled on TV or Mac',
    'fr': 'AirPlay activé sur la TV ou le Mac',
    'es': 'AirPlay activado en la TV o Mac',
    'ar': 'تفعيل AirPlay على التلفاز أو Mac',
  });

  String get airplayEnabledBody => _t({
    'en':
        'On Apple TV, open Settings > AirPlay and make sure AirPlay is turned on.',
    'fr':
        'Sur Apple TV, ouvrez Réglages > AirPlay et assurez-vous qu’AirPlay est activé.',
    'es':
        'En Apple TV, abre Ajustes > AirPlay y asegúrate de que AirPlay esté activado.',
    'ar': 'على Apple TV، افتح الإعدادات > AirPlay وتأكد من تفعيله.',
  });

  String get disableVpn => _t({
    'en': 'Disable VPN',
    'fr': 'Désactiver le VPN',
    'es': 'Desactivar VPN',
    'ar': 'إيقاف VPN',
  });

  String get disableVpnBody => _t({
    'en': 'VPNs can block local AirPlay discovery. Turn off VPN and try again.',
    'fr':
        'Les VPN peuvent bloquer la découverte AirPlay locale. Désactivez le VPN et réessayez.',
    'es':
        'Las VPN pueden bloquear el descubrimiento local de AirPlay. Desactiva la VPN e inténtalo de nuevo.',
    'ar': 'قد تمنع VPN اكتشاف AirPlay المحلي. أوقف VPN وحاول مرة أخرى.',
  });

  String get restartTvRouter => _t({
    'en': 'Restart TV or router',
    'fr': 'Redémarrer la TV ou le routeur',
    'es': 'Reiniciar TV o router',
    'ar': 'أعد تشغيل التلفاز أو الموجّه',
  });

  String get restartTvRouterBody => _t({
    'en':
        'If no device appears, restart your TV and WiFi router, then open this screen again.',
    'fr':
        'Si aucun appareil n’apparaît, redémarrez votre TV et routeur Wi-Fi, puis rouvrez cet écran.',
    'es':
        'Si no aparece ningún dispositivo, reinicia tu TV y router Wi-Fi y abre esta pantalla de nuevo.',
    'ar':
        'إذا لم يظهر أي جهاز، أعد تشغيل التلفاز وموجّه Wi-Fi ثم افتح هذه الشاشة مرة أخرى.',
  });

  String get airplayTroubleshootNote => _t({
    'en':
        'If your device does not appear in AirPlay, the issue is usually network or AirPlay settings, not the app.',
    'fr':
        'Si votre appareil n’apparaît pas dans AirPlay, le problème vient généralement du réseau ou des réglages AirPlay, pas de l’app.',
    'es':
        'Si tu dispositivo no aparece en AirPlay, el problema suele ser la red o los ajustes de AirPlay, no la app.',
    'ar':
        'إذا لم يظهر جهازك في AirPlay، فالمشكلة عادة في الشبكة أو إعدادات AirPlay وليس التطبيق.',
  });

  String get screenMirroringInstructions => _t({
    'en': 'Screen Mirroring Instructions',
    'fr': 'Instructions de miroir d’écran',
    'es': 'Instrucciones de duplicación de pantalla',
    'ar': 'تعليمات انعكاس الشاشة',
  });

  // Screen mirror
  String get mirroringUsesControlCenter => _t({
    'en': 'Screen Mirroring to your TV',
    'fr': 'Miroir d’écran vers votre TV',
    'es': 'Duplicación de pantalla a tu TV',
    'ar': 'انعكاس الشاشة إلى التلفاز',
  });

  String get mirroringBannerBody => _t({
    'en':
        'Mirror via AirPlay from Control Center, or stream your screen to a smart TV browser on the same Wi‑Fi.',
    'fr':
        'Miroir via AirPlay depuis le Centre de contrôle, ou diffusez votre écran vers le navigateur TV sur le même Wi‑Fi.',
    'es':
        'Duplica vía AirPlay desde el Centro de control, o transmite tu pantalla al navegador de la TV en la misma Wi‑Fi.',
    'ar':
        'اعكس عبر AirPlay من مركز التحكم، أو بث شاشتك إلى متصفح التلفاز على نفس شبكة Wi‑Fi.',
  });

  String get airPlayMirrorStatus => _t({
    'en': 'AirPlay mirror status',
    'fr': 'État du miroir AirPlay',
    'es': 'Estado de duplicación AirPlay',
    'ar': 'حالة انعكاس AirPlay',
  });

  String get airPlayMirrorActive => _t({
    'en': 'Screen mirroring is active',
    'fr': 'Le miroir d’écran est actif',
    'es': 'La duplicación de pantalla está activa',
    'ar': 'انعكاس الشاشة نشط',
  });

  String get airPlayMirrorInactive => _t({
    'en': 'Not mirroring yet',
    'fr': 'Miroir pas encore actif',
    'es': 'Aún no se está duplicando',
    'ar': 'الانعكاس غير نشط بعد',
  });

  String get refreshStatus => _t({
    'en': 'Refresh status',
    'fr': 'Actualiser le statut',
    'es': 'Actualizar estado',
    'ar': 'تحديث الحالة',
  });

  String get wifiTvMirror => _t({
    'en': 'Wi‑Fi TV browser mirror',
    'fr': 'Miroir navigateur TV Wi‑Fi',
    'es': 'Duplicación en navegador TV Wi‑Fi',
    'ar': 'انعكاس متصفح التلفاز عبر Wi‑Fi',
  });

  String get wifiTvMirrorBody => _t({
    'en':
        'Start mirroring, then open the link below in your TV web browser (Samsung, LG, etc.).',
    'fr':
        'Démarrez le miroir, puis ouvrez le lien ci-dessous dans le navigateur web de votre TV (Samsung, LG, etc.).',
    'es':
        'Inicia la duplicación y abre el enlace en el navegador web de tu TV (Samsung, LG, etc.).',
    'ar':
        'ابدأ الانعكاس ثم افتح الرابط أدناه في متصفح التلفاز (Samsung، LG، إلخ).',
  });

  String get startMirroring => _t({
    'en': 'Start screen mirroring',
    'fr': 'Démarrer le miroir d’écran',
    'es': 'Iniciar duplicación de pantalla',
    'ar': 'بدء انعكاس الشاشة',
  });

  String get stopMirroring => _t({
    'en': 'Stop screen mirroring',
    'fr': 'Arrêter le miroir d’écran',
    'es': 'Detener duplicación de pantalla',
    'ar': 'إيقاف انعكاس الشاشة',
  });

  String get mirrorUrlLabel => _t({
    'en': 'Open on your TV browser',
    'fr': 'Ouvrir dans le navigateur TV',
    'es': 'Abrir en el navegador de la TV',
    'ar': 'افتح في متصفح التلفاز',
  });

  String get copyMirrorUrl => _t({
    'en': 'Copy link',
    'fr': 'Copier le lien',
    'es': 'Copiar enlace',
    'ar': 'نسخ الرابط',
  });

  String get mirrorUrlCopied => _t({
    'en': 'Link copied',
    'fr': 'Lien copié',
    'es': 'Enlace copiado',
    'ar': 'تم نسخ الرابط',
  });

  String get mirrorStartFailed => _t({
    'en':
        'Could not start screen mirroring. Allow screen recording when prompted.',
    'fr':
        'Impossible de démarrer le miroir. Autorisez l’enregistrement d’écran lorsque demandé.',
    'es':
        'No se pudo iniciar la duplicación. Permite la grabación de pantalla cuando se solicite.',
    'ar': 'تعذر بدء الانعكاس. اسمح بتسجيل الشاشة عند الطلب.',
  });

  String get airPlayMirrorSection => _t({
    'en': 'AirPlay screen mirror',
    'fr': 'Miroir d’écran AirPlay',
    'es': 'Duplicación AirPlay',
    'ar': 'انعكاس شاشة AirPlay',
  });

  String step(int n) => _t({
    'en': 'Step $n',
    'fr': 'Étape $n',
    'es': 'Paso $n',
    'ar': 'الخطوة $n',
  });

  String get step1Body => _t({
    'en': 'Open Control Center on your iPhone.',
    'fr': 'Ouvrez le Centre de contrôle sur votre iPhone.',
    'es': 'Abre el Centro de control en tu iPhone.',
    'ar': 'افتح مركز التحكم على هاتفك.',
  });

  String get step2Body => _t({
    'en': 'Tap Screen Mirroring.',
    'fr': 'Touchez Miroir d’écran.',
    'es': 'Toca Duplicar pantalla.',
    'ar': 'اضغط انعكاس الشاشة.',
  });

  String get step3Body => _t({
    'en': 'Choose your TV or Mac from the list.',
    'fr': 'Choisissez votre TV ou Mac dans la liste.',
    'es': 'Elige tu TV o Mac de la lista.',
    'ar': 'اختر التلفاز أو Mac من القائمة.',
  });

  String get step4Body => _t({
    'en': 'To stop, open Control Center again and tap Stop Mirroring.',
    'fr':
        'Pour arrêter, rouvrez le Centre de contrôle et touchez Arrêter le miroir.',
    'es':
        'Para detener, abre el Centro de control de nuevo y toca Dejar de duplicar.',
    'ar': 'للإيقاف، افتح مركز التحكم مرة أخرى واضغط إيقاف الانعكاس.',
  });

  String get mirroringWarning => _t({
    'en':
        'AirPlay mirroring is started from Control Center. Wi‑Fi browser mirroring requires the same Wi‑Fi network on phone and TV.',
    'fr':
        'Le miroir AirPlay se lance depuis le Centre de contrôle. Le miroir navigateur Wi‑Fi nécessite le même réseau Wi‑Fi.',
    'es':
        'La duplicación AirPlay se inicia desde el Centro de control. La duplicación por navegador Wi‑Fi requiere la misma red Wi‑Fi.',
    'ar':
        'يبدأ انعكاس AirPlay من مركز التحكم. انعكاس المتصفح عبر Wi‑Fi يتطلب نفس شبكة Wi‑Fi للهاتف والتلفاز.',
  });

  String get viewDetailedInstructions => _t({
    'en': 'View Detailed Instructions',
    'fr': 'Voir les instructions détaillées',
    'es': 'Ver instrucciones detalladas',
    'ar': 'عرض التعليمات التفصيلية',
  });

  // Photo
  String get noPhotoSelected => _t({
    'en': 'No photo selected',
    'fr': 'Aucune photo sélectionnée',
    'es': 'Ninguna foto seleccionada',
    'ar': 'لم يتم اختيار صورة',
  });

  String get choosePhotoMessage => _t({
    'en':
        'Choose a photo from your library to preview it and cast with AirPlay.',
    'fr':
        'Choisissez une photo dans votre bibliothèque pour la prévisualiser et la diffuser avec AirPlay.',
    'es':
        'Elige una foto de tu biblioteca para previsualizarla y transmitirla con AirPlay.',
    'ar': 'اختر صورة من مكتبتك لمعاينتها وبثها عبر AirPlay.',
  });

  String get choosePhoto => _t({
    'en': 'Choose Photo',
    'fr': 'Choisir une photo',
    'es': 'Elegir foto',
    'ar': 'اختر صورة',
  });

  String get chooseAnotherPhoto => _t({
    'en': 'Choose Another Photo',
    'fr': 'Choisir une autre photo',
    'es': 'Elegir otra foto',
    'ar': 'اختر صورة أخرى',
  });

  String get photoPreview => _t({
    'en': 'Photo Preview',
    'fr': 'Aperçu photo',
    'es': 'Vista previa de foto',
    'ar': 'معاينة الصورة',
  });

  String get noPhotoCancelled => _t({
    'en': 'No photo selected. You can choose one anytime.',
    'fr':
        'Aucune photo sélectionnée. Vous pouvez en choisir une à tout moment.',
    'es': 'Ninguna foto seleccionada. Puedes elegir una en cualquier momento.',
    'ar': 'لم يتم اختيار صورة. يمكنك الاختيار في أي وقت.',
  });

  String get photoStillShown => _t({
    'en': 'No photo selected. Your current photo is still shown.',
    'fr':
        'Aucune photo sélectionnée. Votre photo actuelle est toujours affichée.',
    'es': 'Ninguna foto seleccionada. Tu foto actual sigue mostrándose.',
    'ar': 'لم يتم اختيار صورة. صورتك الحالية لا تزال معروضة.',
  });

  String get showOnTv => _t({
    'en': 'Show on TV',
    'fr': 'Afficher sur la TV',
    'es': 'Mostrar en la TV',
    'ar': 'عرض على التلفاز',
  });

  String get tapAirplayPhoto => _t({
    'en': 'Tap AirPlay to show this photo on a compatible device.',
    'fr':
        'Touchez AirPlay pour afficher cette photo sur un appareil compatible.',
    'es': 'Toca AirPlay para mostrar esta foto en un dispositivo compatible.',
    'ar': 'اضغط AirPlay لعرض هذه الصورة على جهاز متوافق.',
  });

  String get chooseAirplayDevice => _t({
    'en': 'Choose an AirPlay device',
    'fr': 'Choisir un appareil AirPlay',
    'es': 'Elegir un dispositivo AirPlay',
    'ar': 'اختر جهاز AirPlay',
  });

  String get airplay => 'AirPlay';

  String get photoAirplayHint => _t({
    'en':
        'If no device appears, make sure your iPhone and TV are on the same WiFi and AirPlay is enabled on your TV or Mac.',
    'fr':
        'Si aucun appareil n’apparaît, assurez-vous que votre iPhone et votre TV sont sur le même Wi-Fi et qu’AirPlay est activé.',
    'es':
        'Si no aparece ningún dispositivo, asegúrate de que tu iPhone y TV estén en la misma Wi-Fi y que AirPlay esté activado.',
    'ar':
        'إذا لم يظهر جهاز، تأكد من أن الهاتف والتلفاز على نفس Wi-Fi وأن AirPlay مفعّل.',
  });

  // Video
  String get noVideoSelected => _t({
    'en': 'No video selected',
    'fr': 'Aucune vidéo sélectionnée',
    'es': 'Ningún video seleccionado',
    'ar': 'لم يتم اختيار فيديو',
  });

  String get chooseVideoMessage => _t({
    'en': 'Choose a video from your library to play it with AirPlay support.',
    'fr':
        'Choisissez une vidéo dans votre bibliothèque pour la lire avec AirPlay.',
    'es':
        'Elige un video de tu biblioteca para reproducirlo con soporte AirPlay.',
    'ar': 'اختر فيديو من مكتبتك لتشغيله مع دعم AirPlay.',
  });

  String get chooseVideo => _t({
    'en': 'Choose Video',
    'fr': 'Choisir une vidéo',
    'es': 'Elegir video',
    'ar': 'اختر فيديو',
  });

  String get chooseAnotherVideo => _t({
    'en': 'Choose Another Video',
    'fr': 'Choisir une autre vidéo',
    'es': 'Elegir otro video',
    'ar': 'اختر فيديو آخر',
  });

  String get openingVideo => _t({
    'en': 'Opening video...',
    'fr': 'Ouverture de la vidéo...',
    'es': 'Abriendo video...',
    'ar': 'جارٍ فتح الفيديو...',
  });

  String get loadingVideo => _t({
    'en': 'Loading video...',
    'fr': 'Chargement de la vidéo...',
    'es': 'Cargando video...',
    'ar': 'جارٍ تحميل الفيديو...',
  });

  String get videoCannotPlay => _t({
    'en': 'Video cannot play',
    'fr': 'Impossible de lire la vidéo',
    'es': 'No se puede reproducir el video',
    'ar': 'تعذر تشغيل الفيديو',
  });

  String get videoNotFound => _t({
    'en': 'This video file could not be found. Please choose another video.',
    'fr': 'Ce fichier vidéo est introuvable. Veuillez choisir une autre vidéo.',
    'es': 'No se encontró este archivo de video. Elige otro video.',
    'ar': 'تعذر العثور على ملف الفيديو. يرجى اختيار فيديو آخر.',
  });

  String get videoCannotOpen => _t({
    'en': 'This video file could not be opened. Try choosing another video.',
    'fr': 'Ce fichier vidéo n’a pas pu être ouvert. Essayez une autre vidéo.',
    'es': 'No se pudo abrir este archivo de video. Prueba con otro.',
    'ar': 'تعذر فتح ملف الفيديو. جرّب فيديو آخر.',
  });

  String get noVideoCancelled => _t({
    'en': 'No video selected. You can choose one anytime.',
    'fr':
        'Aucune vidéo sélectionnée. Vous pouvez en choisir une à tout moment.',
    'es': 'Ningún video seleccionado. Puedes elegir uno en cualquier momento.',
    'ar': 'لم يتم اختيار فيديو. يمكنك الاختيار في أي وقت.',
  });

  String get videoStillLoaded => _t({
    'en': 'No video selected. Your current video is still loaded.',
    'fr':
        'Aucune vidéo sélectionnée. Votre vidéo actuelle est toujours chargée.',
    'es': 'Ningún video seleccionado. Tu video actual sigue cargado.',
    'ar': 'لم يتم اختيار فيديو. الفيديو الحالي لا يزال محمّلًا.',
  });

  String get videoPlayer => _t({
    'en': 'Video Player',
    'fr': 'Lecteur vidéo',
    'es': 'Reproductor de video',
    'ar': 'مشغل الفيديو',
  });

  String get unableToPlayVideo => _t({
    'en': 'Unable to play this video.',
    'fr': 'Impossible de lire cette vidéo.',
    'es': 'No se puede reproducir este video.',
    'ar': 'تعذر تشغيل هذا الفيديو.',
  });

  String get castWithAirplay => _t({
    'en': 'Cast with AirPlay',
    'fr': 'Diffuser avec AirPlay',
    'es': 'Transmitir con AirPlay',
    'ar': 'البث عبر AirPlay',
  });

  String get castVideoBody => _t({
    'en':
        'After selecting a video, use the AirPlay button in the player controls or below to stream to Apple TV or an AirPlay-compatible device.',
    'fr':
        'Après avoir sélectionné une vidéo, utilisez le bouton AirPlay dans les contrôles du lecteur ou ci-dessous pour diffuser vers Apple TV ou un appareil compatible AirPlay.',
    'es':
        'Después de seleccionar un video, usa el botón AirPlay en los controles del reproductor o abajo para transmitir a Apple TV o un dispositivo compatible con AirPlay.',
    'ar':
        'بعد اختيار فيديو، استخدم زر AirPlay في عناصر التحكم بالمشغل أو أدناه للبث إلى Apple TV أو جهاز متوافق مع AirPlay.',
  });

  String get castToTv => _t({
    'en': 'Cast to TV',
    'fr': 'Diffuser sur la TV',
    'es': 'Transmitir a la TV',
    'ar': 'البث إلى التلفاز',
  });

  String get castVideoPlayerBody => _t({
    'en':
        'Use the AirPlay button in the player controls to stream this video to Apple TV or an AirPlay-compatible device.',
    'fr':
        'Utilisez le bouton AirPlay dans les contrôles du lecteur pour diffuser cette vidéo vers Apple TV ou un appareil compatible AirPlay.',
    'es':
        'Usa el botón AirPlay en los controles del reproductor para transmitir este video a Apple TV o un dispositivo compatible con AirPlay.',
    'ar':
        'استخدم زر AirPlay في عناصر التحكم بالمشغل لبث هذا الفيديو إلى Apple TV أو جهاز متوافق مع AirPlay.',
  });

  String get orPickDevice => _t({
    'en': 'Or pick a device here',
    'fr': 'Ou choisissez un appareil ici',
    'es': 'O elige un dispositivo aquí',
    'ar': 'أو اختر جهازًا هنا',
  });

  // Browser
  String get enterUrl => _t({
    'en': 'Enter URL',
    'fr': 'Entrer l’URL',
    'es': 'Introducir URL',
    'ar': 'أدخل الرابط',
  });

  String get pageFailedToLoad => _t({
    'en': 'Page failed to load',
    'fr': 'Échec du chargement de la page',
    'es': 'Error al cargar la página',
    'ar': 'فشل تحميل الصفحة',
  });

  String get tryAgain => _t({
    'en': 'Try Again',
    'fr': 'Réessayer',
    'es': 'Intentar de nuevo',
    'ar': 'حاول مرة أخرى',
  });

  String get invalidUrl => _t({
    'en': 'Invalid URL. Please enter a valid web address.',
    'fr': 'URL invalide. Veuillez entrer une adresse web valide.',
    'es': 'URL no válida. Introduce una dirección web válida.',
    'ar': 'رابط غير صالح. يرجى إدخال عنوان ويب صحيح.',
  });

  String get invalidUrlExample => _t({
    'en': 'Invalid URL. Example: youtube.com or https://example.com',
    'fr': 'URL invalide. Exemple : youtube.com ou https://example.com',
    'es': 'URL no válida. Ejemplo: youtube.com o https://example.com',
    'ar': 'رابط غير صالح. مثال: youtube.com أو https://example.com',
  });

  String get pageLoadFailed => _t({
    'en': 'This page failed to load.',
    'fr': 'Le chargement de cette page a échoué.',
    'es': 'Esta página no se pudo cargar.',
    'ar': 'فشل تحميل هذه الصفحة.',
  });

  // Link video
  String pasteLinkDescription(String label) => _t({
    'en':
        'Paste a $label video link to open it in the in-app browser. You can then use AirPlay from the browser toolbar to cast to your TV.',
    'fr':
        'Collez un lien vidéo $label pour l’ouvrir dans le navigateur intégré. Vous pourrez ensuite utiliser AirPlay depuis la barre d’outils pour diffuser sur votre TV.',
    'es':
        'Pega un enlace de video de $label para abrirlo en el navegador integrado. Luego puedes usar AirPlay desde la barra de herramientas para transmitir a tu TV.',
    'ar':
        'الصق رابط فيديو $label لفتحه في المتصفح داخل التطبيق. ثم يمكنك استخدام AirPlay من شريط الأدوات للبث إلى التلفاز.',
  });

  String linkLabel(String label) => _t({
    'en': '$label link',
    'fr': 'Lien $label',
    'es': 'Enlace de $label',
    'ar': 'رابط $label',
  });

  String get pasteLinkFirst => _t({
    'en': 'Please paste a link first.',
    'fr': 'Veuillez d’abord coller un lien.',
    'es': 'Primero pega un enlace.',
    'ar': 'يرجى لصق رابط أولاً.',
  });

  String get invalidYoutubeLink => _t({
    'en': 'Enter a valid YouTube link from youtube.com or youtu.be.',
    'fr': 'Entrez un lien YouTube valide depuis youtube.com ou youtu.be.',
    'es': 'Introduce un enlace válido de YouTube desde youtube.com o youtu.be.',
    'ar': 'أدخل رابط YouTube صالحًا من youtube.com أو youtu.be.',
  });

  String get invalidVimeoLink => _t({
    'en': 'Enter a valid Vimeo link from vimeo.com.',
    'fr': 'Entrez un lien Vimeo valide depuis vimeo.com.',
    'es': 'Introduce un enlace válido de Vimeo desde vimeo.com.',
    'ar': 'أدخل رابط Vimeo صالحًا من vimeo.com.',
  });

  String get invalidLink => _t({
    'en': 'This link looks invalid. Please check and try again.',
    'fr': 'Ce lien semble invalide. Veuillez vérifier et réessayer.',
    'es': 'Este enlace parece no válido. Compruébalo e inténtalo de nuevo.',
    'ar': 'يبدو أن هذا الرابط غير صالح. يرجى التحقق والمحاولة مرة أخرى.',
  });

  String get openInBrowser => _t({
    'en': 'Open in Browser',
    'fr': 'Ouvrir dans le navigateur',
    'es': 'Abrir en el navegador',
    'ar': 'فتح في المتصفح',
  });

  // Remote
  String get aboutRemote => _t({
    'en': 'About TV remote control',
    'fr': 'À propos de la télécommande TV',
    'es': 'Acerca del control remoto de TV',
    'ar': 'حول التحكم عن بُعد بالتلفاز',
  });

  String get aboutRemoteBody => _t({
    'en':
        'This app uses Apple\'s native AirPlay features. It does not emulate a universal TV remote or claim control over TVs that are not connected through supported Apple protocols.',
    'fr':
        'Cette app utilise les fonctionnalités AirPlay natives d’Apple. Elle n’émule pas une télécommande universelle ni ne prétend contrôler des TV non connectées via les protocoles Apple pris en charge.',
    'es':
        'Esta app usa las funciones nativas de AirPlay de Apple. No emula un control remoto universal ni controla TVs no conectadas mediante protocolos Apple compatibles.',
    'ar':
        'يستخدم هذا التطبيق ميزات AirPlay الأصلية من Apple. لا يحاكي جهاز تحكم عن بُعد عام ولا يدّعي التحكم بأجهزة تلفاز غير متصلة عبر بروتوكولات Apple المدعومة.',
  });

  String get whenAirplayActive => _t({
    'en': 'When AirPlay is active',
    'fr': 'Quand AirPlay est actif',
    'es': 'Cuando AirPlay está activo',
    'ar': 'عند تفعيل AirPlay',
  });

  String get remoteStep1 => _t({
    'en':
        'Use Control Center volume controls to adjust playback volume while casting.',
    'fr':
        'Utilisez les contrôles de volume du Centre de contrôle pendant la diffusion.',
    'es':
        'Usa los controles de volumen del Centro de control mientras transmites.',
    'ar': 'استخدم عناصر التحكم بالصوت في مركز التحكم أثناء البث.',
  });

  String get remoteStep2 => _t({
    'en':
        'Use the Now Playing card in Control Center to pause or skip AirPlay audio.',
    'fr':
        'Utilisez la carte En cours de lecture dans le Centre de contrôle pour mettre en pause ou passer l’audio AirPlay.',
    'es':
        'Usa la tarjeta En reproducción en el Centro de control para pausar o saltar audio AirPlay.',
    'ar':
        'استخدم بطاقة التشغيل الحالي في مركز التحكم لإيقاف مؤقت أو تخطي صوت AirPlay.',
  });

  String get remoteStep3 => _t({
    'en':
        'For Apple TV, use the Apple TV Remote in Control Center or the Apple TV Remote app.',
    'fr':
        'Pour Apple TV, utilisez la télécommande Apple TV dans le Centre de contrôle ou l’app Apple TV Remote.',
    'es':
        'Para Apple TV, usa el control remoto de Apple TV en el Centro de control o la app Apple TV Remote.',
    'ar':
        'لـ Apple TV، استخدم جهاز التحكم Apple TV في مركز التحكم أو تطبيق Apple TV Remote.',
  });

  String get connectFirst => _t({
    'en': 'Connect first',
    'fr': 'Connectez-vous d’abord',
    'es': 'Conéctate primero',
    'ar': 'اتصل أولاً',
  });

  String get connectFirstBody => _t({
    'en':
        'Remote-style controls work best after you connect to a TV via AirPlay.',
    'fr':
        'Les contrôles de type télécommande fonctionnent mieux après connexion à une TV via AirPlay.',
    'es':
        'Los controles tipo remoto funcionan mejor después de conectar a una TV vía AirPlay.',
    'ar':
        'تعمل عناصر التحكم عن بُعد بشكل أفضل بعد الاتصال بالتلفاز عبر AirPlay.',
  });

  String get pickAirplayDevice => _t({
    'en': 'Pick an AirPlay device',
    'fr': 'Choisir un appareil AirPlay',
    'es': 'Elegir un dispositivo AirPlay',
    'ar': 'اختر جهاز AirPlay',
  });

  String get goToConnect => _t({
    'en': 'Go to Connect to TV',
    'fr': 'Aller à Connecter à la TV',
    'es': 'Ir a Conectar a la TV',
    'ar': 'الانتقال إلى الاتصال بالتلفاز',
  });

  // Mirror instructions
  String get screenMirroringGuide => _t({
    'en': 'Screen Mirroring Guide',
    'fr': 'Guide du miroir d’écran',
    'es': 'Guía de duplicación de pantalla',
    'ar': 'دليل انعكاس الشاشة',
  });

  String get beforeYouStart => _t({
    'en': 'Before you start',
    'fr': 'Avant de commencer',
    'es': 'Antes de empezar',
    'ar': 'قبل البدء',
  });

  String get beforeStep1 => _t({
    'en': 'Ensure your iPhone and TV are on the same WiFi network.',
    'fr':
        'Assurez-vous que votre iPhone et votre TV sont sur le même réseau Wi-Fi.',
    'es': 'Asegúrate de que tu iPhone y TV estén en la misma red Wi-Fi.',
    'ar': 'تأكد من أن هاتفك والتلفاز على نفس شبكة Wi-Fi.',
  });

  String get beforeStep2 => _t({
    'en': 'Wake your TV and confirm AirPlay or Screen Mirroring is supported.',
    'fr':
        'Allumez votre TV et confirmez que AirPlay ou le miroir d’écran est pris en charge.',
    'es':
        'Enciende tu TV y confirma que AirPlay o Duplicar pantalla es compatible.',
    'ar': 'شغّل التلفاز وتأكد من دعم AirPlay أو انعكاس الشاشة.',
  });

  String get beforeStep3 => _t({
    'en': 'Disable VPN if your TV does not appear in the device list.',
    'fr':
        'Désactivez le VPN si votre TV n’apparaît pas dans la liste des appareils.',
    'es': 'Desactiva la VPN si tu TV no aparece en la lista de dispositivos.',
    'ar': 'أوقف VPN إذا لم يظهر التلفاز في قائمة الأجهزة.',
  });

  String get startFromControlCenter => _t({
    'en': 'Start mirroring from Control Center',
    'fr': 'Démarrer le miroir depuis le Centre de contrôle',
    'es': 'Iniciar duplicación desde el Centro de control',
    'ar': 'ابدأ الانعكاس من مركز التحكم',
  });

  String get ccStep1 => _t({
    'en':
        'Swipe down from the top-right corner of your iPhone (or up from the bottom on older models) to open Control Center.',
    'fr':
        'Balayez depuis le coin supérieur droit de votre iPhone (ou depuis le bas sur les anciens modèles) pour ouvrir le Centre de contrôle.',
    'es':
        'Desliza desde la esquina superior derecha de tu iPhone (o desde abajo en modelos antiguos) para abrir el Centro de control.',
    'ar':
        'اسحب من الزاوية العلوية اليمنى لهاتفك (أو من الأسفل في الطرازات الأقدم) لفتح مركز التحكم.',
  });

  String get ccStep4 => _t({
    'en': 'Enter the AirPlay code on your TV if prompted.',
    'fr': 'Entrez le code AirPlay sur votre TV si demandé.',
    'es': 'Introduce el código AirPlay en tu TV si se solicita.',
    'ar': 'أدخل رمز AirPlay على التلفاز إذا طُلب منك ذلك.',
  });

  String get ccStep5 => _t({
    'en':
        'To stop mirroring, open Control Center and tap Screen Mirroring again, then tap Stop Mirroring.',
    'fr':
        'Pour arrêter, ouvrez le Centre de contrôle, touchez à nouveau Miroir d’écran, puis Arrêter le miroir.',
    'es':
        'Para detener, abre el Centro de control, toca Duplicar pantalla de nuevo y luego Dejar de duplicar.',
    'ar':
        'للإيقاف، افتح مركز التحكم واضغط انعكاس الشاشة مرة أخرى ثم إيقاف الانعكاس.',
  });

  String get airplayForVideo => _t({
    'en': 'Alternative: AirPlay for video',
    'fr': 'Alternative : AirPlay pour la vidéo',
    'es': 'Alternativa: AirPlay para video',
    'ar': 'بديل: AirPlay للفيديو',
  });

  String get airplayForVideoBody => _t({
    'en':
        'For videos, you can use AirPlay without full screen mirroring. Play a video in this app and tap the AirPlay icon in the player.',
    'fr':
        'Pour les vidéos, vous pouvez utiliser AirPlay sans miroir plein écran. Lisez une vidéo dans cette app et touchez l’icône AirPlay dans le lecteur.',
    'es':
        'Para videos, puedes usar AirPlay sin duplicación completa. Reproduce un video en esta app y toca el icono AirPlay en el reproductor.',
    'ar':
        'للفيديو، يمكنك استخدام AirPlay دون انعكاس كامل للشاشة. شغّل فيديو في هذا التطبيق واضغط أيقونة AirPlay في المشغل.',
  });

  // Misc
  String get iosOnlyAirplay => _t({
    'en': 'Video playback with AirPlay is supported on iOS.',
    'fr': 'La lecture vidéo avec AirPlay est prise en charge sur iOS.',
    'es': 'La reproducción de video con AirPlay es compatible en iOS.',
    'ar': 'تشغيل الفيديو مع AirPlay مدعوم على iOS.',
  });

  String get rateAppMessage => _t({
    'en': 'App Store rating will be available after the app is published.',
    'fr':
        'La notation App Store sera disponible après la publication de l’app.',
    'es':
        'La valoración en App Store estará disponible después de publicar la app.',
    'ar': 'سيكون التقييم على App Store متاحًا بعد نشر التطبيق.',
  });

  String versionLabel(String v) => '$version: $v';
}
