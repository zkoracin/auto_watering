import 'package:client/core/network/api_client_provider.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpRepositoryProvider = Provider<PumpRepository>((ref) {
  return PumpRepository(ref.watch(apiClientProvider));
});
