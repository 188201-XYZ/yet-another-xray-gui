import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xray/core/constants/main.dart';
import 'package:xray/core/util/notifiers/logging_notifier.dart';
import 'package:xray/core/util/notifiers/shared_preferences_notifier.dart';
import 'package:xray/core/util/riverpod_logger.dart';

import 'package:xray/features/settings/presentation/notifiers/app_settings_notifier.dart';
import 'package:xray/core/theme/theme.dart';
import 'package:xray/features/bottom_info_bar/presentation/pages/bottom_info_bar.dart';
import 'package:xray/features/log_view/presentation/pages/log_view.dart';
import 'package:xray/features/menu_bar/menu_bar.dart';
import 'package:xray/features/profile_manager/presentation/pages/profile_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is not safe from the sharedprefs file
  // having some bs as it's contents
  final SharedPreferencesWithCache prefs =
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  final logger = Logger('mainLogger');

  await GoogleFonts.pendingFonts([GoogleFonts.googleSansCode()]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        loggerProvider.overrideWithValue(logger),
      ],
      observers: [RiverpodLogger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return MaterialApp(
          // title: 'Xray',
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ref.watch(
            appSettingsProvider.select((appSettings) => appSettings.themeMode),
          ),
          home: const Scaffold(body: MainPage()),
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [CustomMenuBar(), ProfileManager(), LogView(), BottomInfoBar()],
    );
  }
}
