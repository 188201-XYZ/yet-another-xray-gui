import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckProxySpeedButton extends ConsumerWidget {
  const CheckProxySpeedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Check proxy speed',
      child: IconButton(
        icon: const Icon(Icons.speed),
        mouseCursor: SystemMouseCursors.click,
        onPressed: () {},
      ),
    );
  }
}
