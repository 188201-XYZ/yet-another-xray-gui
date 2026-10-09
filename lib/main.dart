import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'package:yet_another_xray_gui/core/constants/main.dart';
import 'package:yet_another_xray_gui/core/util/notifiers/logging_notifier.dart';
import 'package:yet_another_xray_gui/core/util/notifiers/shared_preferences_notifier.dart';
import 'package:yet_another_xray_gui/core/util/riverpod_logger.dart';

import 'package:yet_another_xray_gui/features/settings/presentation/notifiers/app_settings_notifier.dart';
import 'package:yet_another_xray_gui/core/theme/theme.dart';
import 'package:yet_another_xray_gui/features/bottom_info_bar/presentation/pages/bottom_info_bar.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/pages/log_view.dart';
import 'package:yet_another_xray_gui/features/menu_bar/menu_bar.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/pages/profile_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const options = WindowOptions(
    size: Size(1600, 900),
    minimumSize: Size(1600, 900),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    title: 'xray',
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);

    await windowManager.show();
    await windowManager.setMinimumSize(options.minimumSize!);
    await windowManager.setSize(options.size!);
    // await windowManager.focus();
  });

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
