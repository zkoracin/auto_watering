import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/features/pump/domain/pump_status.dart';
import 'package:client/notifiers/pump_run_time_notifier.dart';
import 'package:client/notifiers/pump_runtime_test_notifier.dart';
import 'package:client/notifiers/pump_schedule_interval_notifier.dart';
import 'package:client/notifiers/pump_schedule_time_notifier.dart';
import 'package:client/notifiers/pump_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpStatusProvider =
    AsyncNotifierProvider<PumpStatusNotifier, PumpStatus>(
      PumpStatusNotifier.new,
    );

final pumpRunTimeProvider = AsyncNotifierProvider<PumpRunTimeNotifier, Runtime>(
  PumpRunTimeNotifier.new,
);

final pumpScheduleIntervalProvider =
    AsyncNotifierProvider<PumpScheduleIntervalNotifier, Schedule>(
      PumpScheduleIntervalNotifier.new,
    );

final pumpScheduleTimeProvider =
    AsyncNotifierProvider<PumpScheduleTimeNotifier, Schedule>(
      PumpScheduleTimeNotifier.new,
    );

final pumpRuntimeTestProvider =
    AsyncNotifierProvider<PumpRuntimeTestNotifier, RuntimeTest>(
      PumpRuntimeTestNotifier.new,
    );
