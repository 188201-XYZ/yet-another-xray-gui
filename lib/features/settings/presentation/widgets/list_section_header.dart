import 'package:material_ui/material_ui.dart';

class ListSectionHeader extends StatelessWidget {
  const ListSectionHeader({super.key, this.title, this.useTopPadding = true});

  final String? title;
  final bool useTopPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: useTopPadding ? 8.0 : 0.0),
      child: Text(
        title ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
