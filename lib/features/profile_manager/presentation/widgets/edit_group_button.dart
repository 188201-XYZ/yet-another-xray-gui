import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/profile_manager/presentation/providers/profile_list_provider.dart';
import 'package:xray/features/profile_manager/presentation/pages/group_editor_dialog.dart';

class EditGroupButton extends ConsumerWidget {
  const EditGroupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditable = ref.watch(selectedGroupProvider).editable;

    return Tooltip(
      message: isEditable
          ? 'Edit currently selected group'
          : 'Can\'t edit this group',
      child: IconButton(
        icon: const Icon(Icons.edit),
        mouseCursor: isEditable ? SystemMouseCursors.click : null,
        onPressed: isEditable
            ? () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => GroupEditorDialog(
                    // groupDto: ref.read(selectedGroupProvider).toDto(),
                  ),
                );
              }
            : null,
      ),
    );
  }
}
