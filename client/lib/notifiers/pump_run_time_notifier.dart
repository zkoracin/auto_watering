import 'dart:async';
import 'package:client/models/pump_run_time.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpRunTimeNotifier extends AsyncNotifier<PumpRunTime> {
  late final PumpService _pumpService;

  @override
  FutureOr<PumpRunTime> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpRunTime();
  }

  Future<void> updatePumpRunTime(int seconds) async {
    final response = await _pumpService.updatePumpRunTime(seconds);
    state = AsyncData(response);
  }
}
