import 'package:client/providers/dio_provider.dart';
import 'package:client/services/esp_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final espServiceProvider = Provider<EspService>((ref) {
  final dio = ref.read(dioProvider);
  return EspService(dio);
});
