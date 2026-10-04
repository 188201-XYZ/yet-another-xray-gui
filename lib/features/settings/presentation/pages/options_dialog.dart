import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:xray/core/constants/main.dart';
import 'package:xray/core/util/util.dart' show CapitalizedString;
import 'package:xray/features/settings/presentation/notifiers/app_settings_notifier.dart';
import 'package:xray/features/settings/presentation/widgets/alert_dialog_tab.dart';
import 'package:xray/features/settings/presentation/widgets/alert_dialog_with_vertical_tabs.dart';
import 'package:xray/features/settings/presentation/widgets/list_section_header.dart';
import 'package:xray/features/settings/presentation/widgets/theme_selector.dart';

class OptionsDialog extends ConsumerStatefulWidget {
  const OptionsDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends ConsumerState<OptionsDialog> {
  final List<String> _tabs = ['General', 'XRAY', 'System Proxy', 'TUN Mode'];

  @override
  Widget build(BuildContext context) {
    return AlertDialogWithVerticalTabs(
      tabs: _tabs,
      children: const [
        GeneralSettingsTab(),
        XraySettingsTab(),
        SystemProxySettingsTab(),
        TunModeSettingsTab(),
      ],
    );
  }
}

class GeneralSettingsTab extends ConsumerWidget {
  const GeneralSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialogTab(
      children: [
        const ListSectionHeader(title: 'User Interface', useTopPadding: false),

        const ListTile(
          title: Text('Theme'),
          subtitle: Text('Which theme should $APP_NAME use'),
          trailing: ThemeSelector(),
        ),

        const ListSectionHeader(title: 'System'),

        SwitchListTile(
          title: const Text('Launch on boot'),
          subtitle: Text(
            'Should $APP_NAME start after ${OS_NAME.toCapitalized()} boots up',
          ),
          value: ref.watch(appSettingsProvider).startOnSystemStartup,
          onChanged: ref.read(appSettingsProvider.notifier).setStartOnStartup,
        ),
        SwitchListTile(
          title: const Text('Launch hidden'),
          subtitle: const Text(
            'Should $APP_NAME be hidden in the tray on start',
          ),
          value: ref.watch(appSettingsProvider).startHidden,
          onChanged: ref.read(appSettingsProvider.notifier).setStartHidden,
        ),
      ],
    );
  }
}

class XraySettingsTab extends ConsumerWidget {
  const XraySettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AlertDialogTab(children: []);
  }
}

class SystemProxySettingsTab extends ConsumerWidget {
  const SystemProxySettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AlertDialogTab(children: []);
  }
}

class TunModeSettingsTab extends ConsumerWidget {
  const TunModeSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AlertDialogTab(children: []);
  }
}
