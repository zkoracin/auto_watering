import 'package:client/core/network/api_client_provider.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/pump_status.dart';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/features/pump/state/pump_status_notifier.dart';
import 'package:client/features/pump/state/runtime_notifier.dart';
import 'package:client/features/pump/state/runtime_test_notifier.dart';
import 'package:client/features/pump/state/schedule_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpRepositoryProvider = Provider<PumpRepository>(
  (ref) => PumpRepository(ref.read(apiClientProvider)),
);

final runtimeProvider = AsyncNotifierProvider<RuntimeNotifier, Runtime>(
  () => RuntimeNotifier(),
);

final runtimeTestProvider =
    AsyncNotifierProvider<RuntimeTestNotifier, RuntimeTest>(
      () => RuntimeTestNotifier(),
    );

final pumpStatusProvider =
    AsyncNotifierProvider<PumpStatusNotifier, PumpStatus>(
      () => PumpStatusNotifier(),
    );

final scheduleProvider = AsyncNotifierProvider<ScheduleNotifier, Schedule>(
  () => ScheduleNotifier(),
);
