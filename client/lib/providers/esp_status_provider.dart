import 'package:client/models/esp_status.dart';
import 'package:client/providers/esp_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final espStatusProvider = FutureProvider<EspStatus>((ref) async {
  final service = ref.read(espServiceProvider);
  return service.getStatus();
});
