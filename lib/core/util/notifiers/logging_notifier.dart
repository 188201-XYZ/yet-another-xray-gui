import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logging/logging.dart';

part 'logging_notifier.g.dart';

@Riverpod(keepAlive: true)
Logger logger(Ref ref) => throw UnimplementedError();
