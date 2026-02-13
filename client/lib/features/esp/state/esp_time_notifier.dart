import 'dart:async';
import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/data/esp_repository.dart';
import 'package:client/features/esp/domain/esp_time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeNotifier extends AsyncNotifier<EspTime> {
  EspRepository get _repository => ref.read(espRepositoryProvider);

  @override
  FutureOr<EspTime> build() async => _repository.getTime();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getTime());
  }

  Future<void> updateEspTime() async {
    state = const AsyncLoading();
    final now = DateTime.now();
    final currentTime = EspTime(
      day: now.weekday,
      hour: now.hour,
      minute: now.minute,
    );
    state = await AsyncValue.guard(() => _repository.setTime(currentTime));
  }
}
