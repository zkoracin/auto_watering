import 'dart:async';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpRunTimeNotifier extends AsyncNotifier<Runtime> {
  late final PumpService _pumpService;

  @override
  FutureOr<Runtime> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpRunTime();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpService.getPumpRunTime());
  }

  Future<void> updatePumpRunTime(int seconds) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _pumpService.updatePumpRunTime(seconds),
    );
  }
}
