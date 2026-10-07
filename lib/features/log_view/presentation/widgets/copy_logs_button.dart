import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_xray_gui/features/log_view/domain/log_entry.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/providers/log_list_provider.dart';

class CopyLogsButton extends ConsumerWidget {
  const CopyLogsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      icon: const Icon(Icons.copy),
      label: const Text('Copy logs'),
      onPressed: () async {
        final List<LogEntry> logList =
            ref.read(filteredLogListProvider) ?? ref.read(logListProvider);
        await Clipboard.setData(ClipboardData(text: logList.join('\n')));
      },
    );
  }
}
