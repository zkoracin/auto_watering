import 'dart:async';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/domain/pump_status.dart';

class PumpStatusNotifier extends AsyncNotifier<PumpStatus> {
  late final PumpRepository _pumpRepository;

  @override
  FutureOr<PumpStatus> build() async {
    _pumpRepository = ref.read(pumpRepositoryProvider);
    return _pumpRepository.getStatus();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpRepository.getStatus());
  }

  Future<void> togglePump() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpRepository.toggle());
  }
}
