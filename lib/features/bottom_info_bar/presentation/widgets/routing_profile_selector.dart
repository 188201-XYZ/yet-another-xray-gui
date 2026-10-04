import 'package:material_ui/material_ui.dart';

class RoutingProfileSelector extends StatelessWidget {
  const RoutingProfileSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const DropdownMenu(
      label: Text('Routing preset'),
      initialSelection: 'value',
      requestFocusOnTap: false,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: 'value', label: 'numero 1'),
        DropdownMenuEntry(value: 'value', label: 'numero 2'),
        DropdownMenuEntry(value: 'value', label: 'numero 3'),
      ],
    );
  }
}
