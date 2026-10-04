import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServersSearchField extends ConsumerWidget {
  const ServersSearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        decoration: const InputDecoration(
          label: Text('Search servers'),
          border: OutlineInputBorder(),
        ),
        onChanged: (searchPrompt) => {},
      ),
    );
  }
}
