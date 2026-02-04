import 'package:client/models/esp_status.dart';
import 'package:client/providers/esp_service_provider.dart';
import 'package:client/services/esp_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspStatusNotifier extends AsyncNotifier<EspStatus> {
  late final EspService _espService;

  @override
  Future<EspStatus> build() async {
    _espService = ref.read(espServiceProvider);
    return _espService.getStatus();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _espService.getStatus());
  }
}
