import 'dart:async';

import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpRuntimeTestNotifier extends AsyncNotifier<RuntimeTest> {
  late final PumpService _pumpService;

  @override
  FutureOr<RuntimeTest> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return const RuntimeTest(pumpOn: false, seconds: 0);
  }

  Future<void> runTest() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpService.testPumpRunTime());
  }
}
