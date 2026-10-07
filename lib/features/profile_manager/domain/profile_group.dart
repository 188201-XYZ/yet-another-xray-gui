import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yet_another_xray_gui/features/profile_manager/domain/dto/profile_group_dto.dart';
import 'package:yet_another_xray_gui/features/profile_manager/domain/xray_profile.dart';

part 'profile_group.g.dart';
part 'profile_group.freezed.dart';

@freezed
sealed class ProfileGroup with _$ProfileGroup {
  @Assert(
    "RegExp(r'([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})|(all)|(ungrouped)').hasMatch(id)",
    'The id field should contain an UUID, "all" or "ungrouped"',
  )
  // TODO: Remove editable and deletable?
  factory ProfileGroup({
    required String id,
    @Default('New Group') String name,
    Uri? subscriptionURL,
    @Default(false) bool enableAutoUpdate,
    @Default(99999) int autoUpdateInterval,
    @Default(<XRAYProfile>[]) List<XRAYProfile> profiles,
    @Default(true) bool editable,
    @Default(true) bool deletable,
  }) = _ProfileGroup;

  factory ProfileGroup.fromJson(Map<String, Object?> json) =>
      _$ProfileGroupFromJson(json);

  factory ProfileGroup.fromDto(String id, ProfileGroupDTO groupDto) {
    return ProfileGroup.fromJson({'id': id, ...groupDto.toJson()});
  }

  // ProfileGroupDTO toDto() {
  //   return ProfileGroupDTO.fromJson({...toJson()}..remove('id'));
  // }
}
