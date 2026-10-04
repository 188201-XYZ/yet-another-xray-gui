import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:xray/core/util/util.dart' show CapitalizedString;
import 'package:xray/features/settings/presentation/notifiers/app_settings_notifier.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SegmentedButton(
      segments: ThemeMode.values.map((ThemeMode mode) {
        return ButtonSegment(
          label: Text(mode.name.toCapitalized()),
          icon: Icon(
            mode == ThemeMode.system
                ? Icons.computer
                : mode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          value: mode,
        );
      }).toList(),
      selected: {ref.watch(appSettingsProvider).themeMode},
      onSelectionChanged: (value) =>
          ref.read(appSettingsProvider.notifier).setTheme(value.first),
    );
  }
}
