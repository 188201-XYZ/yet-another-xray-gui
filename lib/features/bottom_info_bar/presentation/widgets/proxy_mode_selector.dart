import 'package:material_ui/material_ui.dart';

class ProxyModeSelector extends StatelessWidget {
  const ProxyModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const DropdownMenu(
      label: Text('System-wide proxy mode'),
      initialSelection: 'clear',
      width: 200,
      requestFocusOnTap: false,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: 'clear', label: 'Clear proxy'),
        DropdownMenuEntry(value: 'set', label: 'Set proxy'),
        DropdownMenuEntry(value: 'nochange', label: 'Don\'t change proxy'),
        DropdownMenuEntry(value: 'pac', label: 'Set PAC proxy'),
      ],
    );
  }
}
