import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/notifiers/pump_schedule_time_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpScheduleTimeProvider =
    AsyncNotifierProvider<PumpScheduleTimeNotifier, Schedule>(
      PumpScheduleTimeNotifier.new,
    );
