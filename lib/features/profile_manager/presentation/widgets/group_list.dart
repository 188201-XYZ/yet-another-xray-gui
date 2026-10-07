import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:yet_another_xray_gui/features/profile_manager/domain/profile_group.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/providers/profile_list_provider.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList = ref.watch(groupListProvider);

    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          physics: const BouncingScrollPhysics(),
          dragDevices: {
            ...ScrollConfiguration.of(context).dragDevices,
            PointerDeviceKind.mouse,
          },
        ),
        child: ScrollShadow(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
          size: 16.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: groupList.length,
            itemBuilder: (context, index) {
              final ProfileGroup groupObj = groupList[index];
              final String label = groupObj.name;

              const int maxNameLength = 20;
              final bool shouldTrim = label.length > maxNameLength;
              return Tooltip(
                message: shouldTrim ? label : '',
                child: FilterChip(
                  showCheckmark: false,
                  label: Text(
                    shouldTrim
                        ? '${label.substring(0, maxNameLength - 1).trimRight()}…'
                        : label,
                  ),
                  onSelected: (value) {
                    ref
                        .read(groupSelectionProvider.notifier)
                        .setSelectedGroup(groupObj.id);
                  },
                  selected: groupObj.id == ref.watch(groupSelectionProvider),
                ),
              );
            },

            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          ),
        ),
      ),
    );
  }
}
