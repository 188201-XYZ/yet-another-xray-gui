import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:material_ui/material_ui.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yet_another_xray_gui/core/util/notifiers/shared_preferences_notifier.dart';
import 'package:yet_another_xray_gui/features/settings/domain/models/app_settings.dart'
    show AppSettings;

part 'app_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  static const String _settingsKey = 'AppSettingsObject';

  @override
  AppSettings build() {
    listenSelf((previous, next) {
      if (previous != null && previous != next) {
        _saveSettings(next);
      }
    });

    return _loadSettings();
  }

  void _saveSettings(AppSettings settings) {
    ref
        .read(sharedPreferencesProvider)
        .setString(_settingsKey, jsonEncode(settings.toJson()));
  }

  AppSettings _loadSettings() {
    final preferences = ref.read(sharedPreferencesProvider);
    final jsonString = preferences.getString(_settingsKey);
    if (jsonString == null) {
      return const AppSettings();
    }

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is Map<String, Object?>) {
        return AppSettings.fromJson(decoded);
      }
    } on FormatException {
      // fall through to reset invalid data below
    }

    preferences.remove(_settingsKey);
    return const AppSettings();
  }

  void setTheme(ThemeMode value) {
    state = state.copyWith(themeMode: value);
  }

  void setStartOnStartup(bool value) {
    state = state.copyWith(startOnSystemStartup: value);
  }

  void setStartHidden(bool value) {
    state = state.copyWith(startHidden: value);
  }
}
