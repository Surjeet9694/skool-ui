import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skool_ui/core/theme/app_theme.dart';
import 'package:skool_ui/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Lock to portrait mode ───────────────────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ─── System UI overlay style ─────────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // ─── Load environment variables ──────────────────────────────────────────
  await dotenv.load(fileName: '.env');

  // ─── Initialize Hive ─────────────────────────────────────────────────────
  await Hive.initFlutter();

  // ─── Initialize Firebase ─────────────────────────────────────────────────
  // Uncomment when google-services.json / GoogleService-Info.plist are added
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: SkoolApp(),
    ),
  );
}

class SkoolApp extends ConsumerWidget {
  const SkoolApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = createRouter(ref);

    return MaterialApp.router(
      title: 'Skool',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // Respects device preference
      routerConfig: router,
    );
  }
}
