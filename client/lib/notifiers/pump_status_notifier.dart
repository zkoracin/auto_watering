import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/models/pump_status.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';

class PumpStatusNotifier extends AsyncNotifier<PumpStatus> {
  late final PumpService _pumpService;

  @override
  FutureOr<PumpStatus> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpStatus();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpService.getPumpStatus());
  }

  Future<void> togglePump() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _pumpService.togglePump());
  }
}
