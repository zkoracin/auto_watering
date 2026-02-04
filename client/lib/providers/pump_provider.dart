import 'package:client/models/pump_run_time.dart';
import 'package:client/models/pump_schedule.dart';
import 'package:client/models/pump_status.dart';
import 'package:client/notifiers/pump_run_time_notifier.dart';
import 'package:client/notifiers/pump_schedule_interval_notifier.dart';
import 'package:client/notifiers/pump_schedule_time_notifier.dart';
import 'package:client/notifiers/pump_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpStatusProvider =
    AsyncNotifierProvider<PumpStatusNotifier, PumpStatus>(
      PumpStatusNotifier.new,
    );

final pumpRunTimeProvider =
    AsyncNotifierProvider<PumpRunTimeNotifier, PumpRunTime>(
      PumpRunTimeNotifier.new,
    );

final pumpScheduleIntervalProvider =
    AsyncNotifierProvider<PumpScheduleIntervalNotifier, PumpSchedule>(
      PumpScheduleIntervalNotifier.new,
    );

final pumpScheduleTimeProvider =
    AsyncNotifierProvider<PumpScheduleTimeNotifier, PumpSchedule>(
      PumpScheduleTimeNotifier.new,
    );
