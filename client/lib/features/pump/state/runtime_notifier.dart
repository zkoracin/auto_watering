import 'dart:async';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeNotifier extends AsyncNotifier<Runtime> {
  late final PumpRepository _pumpRepository;

  @override
  FutureOr<Runtime> build() async {
    _pumpRepository = ref.read(pumpRepositoryProvider);
    return _pumpRepository.getRuntime();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpRepository.getRuntime());
  }

  Future<void> updateRuntime(int seconds) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _pumpRepository.updateRuntime(seconds),
    );
  }
}
