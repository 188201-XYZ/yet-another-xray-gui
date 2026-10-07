import 'package:freezed_annotation/freezed_annotation.dart';

part 'xray_profile.g.dart';
part 'xray_profile.freezed.dart';

enum XRAYProtocols { vless }

@freezed
sealed class XRAYProfile with _$XRAYProfile {
  @Assert(
    "RegExp(r'([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})|^\$').hasMatch(id ?? '')",
    'The id field should contain an UUID or be empty',
  )
  factory XRAYProfile({
    String? id,
    @Default('New Profile') String name,
    required String tag,
    required XRAYProtocols protocol,
  }) = _XRAYProfile;

  factory XRAYProfile.fromJson(Map<String, Object?> json) =>
      _$XRAYProfileFromJson(json);
}
