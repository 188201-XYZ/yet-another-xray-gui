import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yet_another_xray_gui/features/profile_manager/domain/profile_group.dart';
import 'package:yet_another_xray_gui/features/profile_manager/domain/xray_profile.dart';

part 'profile_list_provider.g.dart';

@riverpod
class UserDefinedGroupListNotifier extends _$UserDefinedGroupListNotifier {
  final Uuid _uuid = const Uuid();

  @override
  List<ProfileGroup> build() {
    // TODO: add persistence
    // if [0].id == ungrouped then don't add it
    return [
      ProfileGroup(
        id: 'ungrouped',
        name: 'Ungrouped Profiles',
        editable: false,
        deletable: false,
      ),
    ];
  }

  void addGroup(ProfileGroup group) {
    state = [...state, group.copyWith(id: _uuid.v7())];
  }

  void editGroup(String groupId, ProfileGroup group) {
    state = state.map((groupElement) {
      if (groupElement.id != groupId) return groupElement;
      return groupElement.copyWith(
        name: group.name,
        subscriptionURL: group.subscriptionURL,
        enableAutoUpdate: group.enableAutoUpdate,
        autoUpdateInterval: group.autoUpdateInterval,
      );
    }).toList();
  }

  void delGroup(String delGroupId) {
    final group = state.firstWhereOrNull((group) => group.id == delGroupId);
    if (group == null || !group.deletable) return;

    if (ref.read(groupSelectionProvider) == delGroupId) {
      ref.read(groupSelectionProvider.notifier).resetSelectedGroup();
    }

    state = state.where((group) => group.id != delGroupId).toList();
  }

  void addProfileToGroup(String groupId, XRAYProfile profile) {
    state = state.map((group) {
      if (group.id != groupId) return group;
      return group.copyWith(
        profiles: [
          ...group.profiles,
          profile.copyWith(id: _uuid.v7()),
        ],
      );
    }).toList();
  }

  void delProfileFromGroup(String delGroupId, String delProfileId) {
    final group = state.firstWhereOrNull((group) => group.id == delGroupId);
    final profile = group?.profiles.firstWhereOrNull(
      (profile) => profile.id == delProfileId,
    );
    if (group == null || profile == null) return;

    if (ref.read(profileSelectionProvider) == delProfileId) {
      ref.read(profileSelectionProvider.notifier).resetSelectedProfile();
    }

    state = state.map((group) {
      if (group.id != delGroupId) return group;
      return group.copyWith(
        profiles: group.profiles
            .where((profile) => profile.id != delProfileId)
            .toList(),
      );
    }).toList();
  }
}

@riverpod
List<ProfileGroup> groupList(Ref ref) {
  final List<ProfileGroup> userDefinedGroups = ref.watch(
    userDefinedGroupListProvider,
  );

  return [
    ProfileGroup(
      id: 'all',
      name: 'All profiles',
      profiles: userDefinedGroups
          .expand((element) => element.profiles)
          .toList(),
      editable: false,
      deletable: false,
    ),
    ...userDefinedGroups,
  ];
}

@riverpod
class GroupSelectionNotifier extends _$GroupSelectionNotifier {
  // TODO: add persistence
  @override
  String build() => 'all';

  void setSelectedGroup(String groupId) => state = groupId;
  void resetSelectedGroup() => state = 'all';
}

@riverpod
class ProfileSelectionNotifier extends _$ProfileSelectionNotifier {
  // TODO: add persistence
  @override
  String? build() => null;

  void setSelectedProfile(String profileId) => state = profileId;
  void resetSelectedProfile() => state = null;
}

@riverpod
ProfileGroup selectedGroup(Ref ref) {
  final groups = ref.watch(groupListProvider);
  final selectedGroupId = ref.watch(groupSelectionProvider);

  return groups.firstWhere((group) => group.id == selectedGroupId);
}

@riverpod
XRAYProfile? selectedProfile(Ref ref) {
  final selectedProfileId = ref.watch(profileSelectionProvider);
  final groups = ref.watch(userDefinedGroupListProvider);

  return groups
      .expand((group) => group.profiles)
      .firstWhereOrNull((profile) => profile.id == selectedProfileId);
}
