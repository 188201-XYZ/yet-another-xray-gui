import 'package:material_ui/material_ui.dart' show ThemeMode;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.g.dart';
part 'app_settings.freezed.dart';

@freezed
sealed class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool startOnSystemStartup,
    @Default(false) bool startHidden,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, Object?> json) =>
      _$AppSettingsFromJson(json);
}
