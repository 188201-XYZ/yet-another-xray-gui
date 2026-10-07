import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_xray_gui/core/util/util.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/providers/profile_list_provider.dart';

class UpdateGroupSubscriptionButton extends ConsumerWidget {
  const UpdateGroupSubscriptionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FIXME: Bad state: No element
    final bool isUpdateable = !ref
        .watch(selectedGroupProvider)
        .subscriptionURL
        .isEmptyOrNull;

    return Tooltip(
      message: isUpdateable
          ? 'Update currently selected group\'s subscription'
          : 'This group doesn\'t have a subscription URL specified',
      child: IconButton(
        icon: const Icon(Icons.cloud_sync),
        mouseCursor: isUpdateable ? SystemMouseCursors.click : null,
        onPressed: isUpdateable ? () {} : null,
      ),
    );
  }
}
