import 'dart:async';
import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/domain/pump_status.dart';

class PumpStatusNotifier extends AsyncNotifier<PumpStatus> {
  PumpRepository get _pumpRepository => ref.read(pumpRepositoryProvider);

  @override
  FutureOr<PumpStatus> build() async => _pumpRepository.getStatus();

  Future<void> togglePump() async {
    state = await AsyncValue.guard(() => _pumpRepository.toggle());
  }
}
