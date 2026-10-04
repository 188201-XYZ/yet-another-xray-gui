import 'package:freezed_annotation/freezed_annotation.dart';

part 'xray_profile_dto.g.dart';
part 'xray_profile_dto.freezed.dart';

enum XRAYProtocols { vless }

@freezed
sealed class XRAYProfileDTO with _$XRAYProfileDTO {
  factory XRAYProfileDTO({
    @Default('New Profile') String name,
    @Default(false) bool selected,
    required String tag,
    required XRAYProtocols protocol,
  }) = _XRAYProfileDTO;

  factory XRAYProfileDTO.fromJson(Map<String, Object?> json) =>
      _$XRAYProfileDTOFromJson(json);
}
