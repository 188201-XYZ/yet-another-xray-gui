import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/profile_manager/presentation/providers/xray_core_provider.dart';

class ReloadButton extends ConsumerWidget {
  const ReloadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuItemButton(
      onPressed: ref.watch(xrayCoreStateProvider)
          ? () => ref.read(xrayCoreStateProvider.notifier).startProcess()
          : null,
      child: const Text('Restart'),
    );
  }
}
