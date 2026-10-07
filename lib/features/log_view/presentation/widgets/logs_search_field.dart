import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/providers/log_list_provider.dart';

class LogsSearchField extends ConsumerWidget {
  const LogsSearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        decoration: const InputDecoration(
          label: Text('Search logs'),
          border: OutlineInputBorder(),
        ),
        onChanged: (searchPrompt) =>
            ref.read(logFilterProvider.notifier).setFilter(searchPrompt),
      ),
    );
  }
}
