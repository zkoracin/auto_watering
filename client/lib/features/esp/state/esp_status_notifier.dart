import 'dart:async';
import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/data/esp_repository.dart';
import 'package:client/features/esp/domain/esp_status.dart';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspStatusNotifier extends AsyncNotifier<EspStatus> {
  EspRepository get _repository => ref.read(espRepositoryProvider);

  @override
  FutureOr<EspStatus> build() async => _repository.getStatus();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getStatus());
    if (state.hasError) {
      return;
    }
    if (ref.read(espTimeNotifierProvider).hasError) {
      ref.invalidate(espTimeNotifierProvider);
    }
    if (ref.read(runtimeProvider).hasError) {
      ref.invalidate(runtimeProvider);
    }
    if (ref.read(runtimeTestProvider).hasError) {
      ref.invalidate(runtimeTestProvider);
    }
    if (ref.read(pumpStatusProvider).hasError) {
      ref.invalidate(pumpStatusProvider);
    }
    if (ref.read(scheduleProvider).hasError) {
      ref.invalidate(scheduleProvider);
    }
  }
}
