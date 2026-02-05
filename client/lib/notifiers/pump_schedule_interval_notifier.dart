import 'dart:async';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpScheduleIntervalNotifier extends AsyncNotifier<Schedule> {
  late final PumpService _pumpService;

  @override
  FutureOr<Schedule> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpSchedule();
  }

  Future<void> updateScheduleInterval(int interval) async {
    final current = state.value;
    if (current == null) return;
    state = const AsyncLoading();
    final updated = current.copyWith(interval: interval);
    state = await AsyncValue.guard(
      () => _pumpService.updatePumpSchedule(updated),
    );
  }
}
