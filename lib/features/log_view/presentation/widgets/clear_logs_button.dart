import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/log_view/presentation/providers/log_list_provider.dart';

class ClearLogsButton extends ConsumerWidget {
  const ClearLogsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text('Clear logs'),
      onPressed: () => ref.read(logListProvider.notifier).clearLogs(),
    );
  }
}
