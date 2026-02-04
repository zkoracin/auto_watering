import 'package:client/models/pump_execution_time.dart';
import 'package:client/notifiers/pump_execution_time_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpExecutionTimeProvider =
    AsyncNotifierProvider<PumpExecutionTimeNotifier, PumpExecutionTime>(
      PumpExecutionTimeNotifier.new,
    );
