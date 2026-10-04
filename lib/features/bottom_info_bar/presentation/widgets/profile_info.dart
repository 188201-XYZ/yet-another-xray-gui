import 'package:material_ui/material_ui.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click to check ping and IP',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            print('tapped');
          },
          child: const Text('Current Profile\ninfo'),
        ),
      ),
    );
  }
}
