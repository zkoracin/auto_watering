import 'dart:async';

import 'package:client/models/pump_execution_time.dart';
import 'package:client/providers/pump_service_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpExecutionTimeNotifier extends AsyncNotifier<PumpExecutionTime> {
  late final PumpService _pumpService;

  @override
  FutureOr<PumpExecutionTime> build() async {
    _pumpService = ref.read(pumpServiceProvider);
    return _pumpService.getPumpExecutionTime();
  }

  Future<void> updateExecutionTime(int seconds) async {
    final response = await _pumpService.setPumpExecutionTime(seconds);
    state = AsyncData(response);
  }
}
