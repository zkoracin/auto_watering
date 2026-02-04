import 'package:client/providers/dio_provider.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpServiceProvider = Provider<PumpService>((ref) {
  final dio = ref.read(dioProvider);
  return PumpService(dio);
});
