import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleNotifier extends AsyncNotifier<Schedule> {
  PumpRepository get _repository => ref.read(pumpRepositoryProvider);

  @override
  Future<Schedule> build() async => _repository.getSchedule();

  Future<void> updateInterval(int intervalLength) async {
    final updated = state.value!.copyWith(intervalLength: intervalLength);
    await _updateField('interval', updated);
  }

  Future<void> updateTime(int hour, int minute) async {
    final updated = state.value!.copyWith(hour: hour, minute: minute);
    await _updateField('time', updated);
  }

  Future<void> updateStartDay(int startDay) async {
    final updated = state.value!.copyWith(startDay: startDay);
    await _updateField('startDay', updated);
  }

  Future<void> _updateField(String fieldName, Schedule updatedModel) async {
    final previousState = state.value;
    if (previousState == null) return;
    state = AsyncValue.data(
      previousState.copyWith(
        loadingFields: {...previousState.loadingFields, fieldName},
      ),
    );
    state = await AsyncValue.guard(() async {
      final result = await _repository.updateSchedule(updatedModel);
      return result.copyWith(
        loadingFields: {...result.loadingFields}..remove(fieldName),
      );
    });
  }
}
