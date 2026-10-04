import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckProxyLatencyButton extends ConsumerWidget {
  const CheckProxyLatencyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Check proxy latency',
      child: IconButton(
        icon: const Icon(Icons.network_ping),
        mouseCursor: SystemMouseCursors.click,
        onPressed: () {},
      ),
    );
  }
}
