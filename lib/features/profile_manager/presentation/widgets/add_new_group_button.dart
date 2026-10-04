import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/profile_manager/domain/dto/profile_group_dto.dart';
import 'package:xray/features/profile_manager/presentation/pages/group_editor_dialog.dart';
import 'package:xray/features/profile_manager/presentation/providers/profile_list_provider.dart';

class AddNewGroupButton extends ConsumerWidget {
  const AddNewGroupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Add a new group',
      child: IconButton(
        icon: const Icon(Icons.add_box_outlined),
        mouseCursor: SystemMouseCursors.click,
        onPressed: () async {
          ProfileGroupDTO? groupDto = await showDialog(
            context: context,
            builder: (BuildContext context) => const GroupEditorDialog(),
          );
          if (groupDto != null) {
            ref.read(userDefinedGroupListProvider.notifier).addGroup(groupDto);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Creating new group "${groupDto.name}"'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
