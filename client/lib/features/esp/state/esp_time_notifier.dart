import 'dart:async';
import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/data/esp_repository.dart';
import 'package:client/features/esp/domain/esp_time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeNotifier extends AsyncNotifier<EspTime> {
  late final EspRepository _repository;

  @override
  FutureOr<EspTime> build() async {
    _repository = ref.read(espRepositoryProvider);
    return _updateEspTime();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _updateEspTime());
  }

  Future<EspTime> _updateEspTime() {
    final now = DateTime.now();
    final currentTime = EspTime(
      day: now.weekday,
      hour: now.hour,
      minute: now.minute,
    );
    return _repository.setTime(currentTime);
  }
}
