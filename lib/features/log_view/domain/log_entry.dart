import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_entry.g.dart';
part 'log_entry.freezed.dart';

@freezed
sealed class LogEntry with _$LogEntry {
  const factory LogEntry({
    required int id,
    required String text,
    required DateTime timeOfCreation,
  }) = _LogEntry;

  factory LogEntry.fromJson(Map<String, Object?> json) =>
      _$LogEntryFromJson(json);
}
