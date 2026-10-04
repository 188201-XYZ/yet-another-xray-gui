import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xray/features/profile_manager/domain/dto/xray_profile_dto.dart';

part 'xray_profile.g.dart';
part 'xray_profile.freezed.dart';

enum XRAYProtocols { vless }

@freezed
sealed class XRAYProfile with _$XRAYProfile {
  @Assert(
    "RegExp(r'([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})').hasMatch(id)",
    'The id field should contain an UUID',
  )
  factory XRAYProfile({
    required String id,
    @Default('New Profile') String name,
    required String tag,
    required XRAYProtocols protocol,
  }) = _XRAYProfile;

  factory XRAYProfile.fromJson(Map<String, Object?> json) =>
      _$XRAYProfileFromJson(json);

  factory XRAYProfile.fromDto(String id, XRAYProfileDTO profileDto) {
    return XRAYProfile.fromJson({'id': id, ...profileDto.toJson()});
  }
}
