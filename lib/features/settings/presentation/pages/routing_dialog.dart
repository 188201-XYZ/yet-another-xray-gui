import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/settings/presentation/widgets/alert_dialog_tab.dart';
import 'package:xray/features/settings/presentation/widgets/alert_dialog_with_vertical_tabs.dart';

class RoutingDialog extends ConsumerStatefulWidget {
  const RoutingDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutingDialogState();
}

class _RoutingDialogState extends ConsumerState<RoutingDialog> {
  final List<String> _tabs = ['Routing Presets', 'Routing Settings'];
  @override
  Widget build(BuildContext context) {
    return AlertDialogWithVerticalTabs(
      tabs: _tabs,
      children: const [AlertDialogTab(), AlertDialogTab()],
    );
  }
}
