import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xray/features/profile_manager/domain/xray_profile.dart';

part 'profile_group_dto.g.dart';
part 'profile_group_dto.freezed.dart';

@freezed
sealed class ProfileGroupDTO with _$ProfileGroupDTO {
  factory ProfileGroupDTO({
    @Default('New Group') String name,
    Uri? subscriptionURL,
    @Default(false) bool selected,
    @Default(false) bool enableAutoUpdate,
    @Default(99999) int autoUpdateInterval,
    @Default(<XRAYProfile>[]) List<XRAYProfile> profiles,
  }) = _ProfileGroupDTO;

  factory ProfileGroupDTO.fromJson(Map<String, Object?> json) =>
      _$ProfileGroupDTOFromJson(json);
}
