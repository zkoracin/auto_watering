import 'dart:async';
import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/data/esp_repository.dart';
import 'package:client/features/esp/domain/esp_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspStatusNotifier extends AsyncNotifier<EspStatus> {
  late final EspRepository _repository;

  @override
  FutureOr<EspStatus> build() async {
    _repository = ref.read(espRepositoryProvider);
    return _repository.getStatus();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getStatus());
  }
}
