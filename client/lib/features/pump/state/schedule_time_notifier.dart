import 'dart:async';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleTimeNotifier extends AsyncNotifier<Schedule> {
  late final PumpRepository _pumpRepository;

  @override
  FutureOr<Schedule> build() async {
    _pumpRepository = ref.read(pumpRepositoryProvider);
    return _pumpRepository.getSchedule();
  }

  Future<void> updateScheduleTime(int hours, int minutes) async {
    final current = state.value;
    if (current == null) return;
    state = const AsyncLoading();
    final updated = current.copyWith(hour: hours, minute: minutes);
    state = await AsyncValue.guard(
      () => _pumpRepository.updateSchedule(updated),
    );
  }
}
