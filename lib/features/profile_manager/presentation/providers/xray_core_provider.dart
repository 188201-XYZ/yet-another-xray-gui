import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/providers/log_list_provider.dart';

part 'xray_core_provider.g.dart';

@riverpod
class XrayCoreStateNotifier extends _$XrayCoreStateNotifier {
  Process? _process;

  @override
  bool build() {
    ref.onDispose(() {
      _process?.kill();
    });

    return false;
  }

  void startProcess() async {
    if (state) return;

    state = true;
    ref.read(logListProvider.notifier).addLogEntry('[system] process started');

    try {
      _process = await Process.start('ping', ['8.8.8.8', '-c99']);

      _process!.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            (line) {
              ref.read(logListProvider.notifier).addLogEntry(line);
            },
            onError: (err) {
              ref.read(logListProvider.notifier).addLogEntry('[error] $err');
            },
            onDone: () {
              state = false;
              ref
                  .read(logListProvider.notifier)
                  .addLogEntry('[system] process finished successfully');
            },
          );
    } catch (e) {
      state = false;

      ref.read(logListProvider.notifier).addLogEntry('[startup error] $e');
    }
  }

  void stopProcess() {
    _process?.kill();
    state = false;
    ref.read(logListProvider.notifier).addLogEntry('[system] process stopped');
  }
}
