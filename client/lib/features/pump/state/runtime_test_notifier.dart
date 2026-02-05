import 'dart:async';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeTestNotifier extends AsyncNotifier<RuntimeTest> {
  late final PumpRepository _pumpRepository;

  @override
  FutureOr<RuntimeTest> build() async {
    _pumpRepository = ref.read(pumpRepositoryProvider);
    return const RuntimeTest(pumpOn: false, seconds: 0);
  }

  Future<void> runTest() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpRepository.testRuntime());
  }
}
