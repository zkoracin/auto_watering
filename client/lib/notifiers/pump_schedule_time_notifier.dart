import 'dart:async';
import 'package:client/models/pump_schedule.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpScheduleTimeNotifier extends AsyncNotifier<PumpSchedule> {
  late final PumpService _pumpService;

  @override
  FutureOr<PumpSchedule> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpSchedule();
  }

  Future<void> updateScheduleTime(int hours, int minutes) async {
    final current = state.value;
    if (current == null) return;
    state = const AsyncLoading();
    final updated = current.copyWith(hour: hours, minute: minutes);
    state = await AsyncValue.guard(
      () => _pumpService.updatePumpSchedule(updated),
    );
  }
}
