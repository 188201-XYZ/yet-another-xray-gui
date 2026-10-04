import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xray/features/log_view/domain/log_entry.dart';

part 'log_list_provider.g.dart';

@riverpod
class LogListNotifier extends _$LogListNotifier {
  @override
  List<LogEntry> build() {
    return [];
  }

  void addLogEntry(String entry) {
    state = [
      ...state,
      // if (state.length < 500) ...state else ...state.skip(1),
      LogEntry(
        id: (state.lastOrNull?.id ?? -1) + 1,
        text: entry,
        timeOfCreation: DateTime.now(),
      ),
    ];
  }

  void clearLogs() {
    state = [];
  }
}

@riverpod
class LogFilterNotifier extends _$LogFilterNotifier {
  @override
  String build() {
    return '';
  }

  void setFilter(String filter) {
    state = filter;
  }
}

@riverpod
List<LogEntry>? filteredLogList(Ref ref) {
  final List<LogEntry> logList = ref.watch(logListProvider);
  final String logFilter = ref.watch(logFilterProvider);

  if (logFilter.isNotEmpty) {
    return logList.where((entry) => entry.text.contains(logFilter)).toList();
  }
  return null;
}
