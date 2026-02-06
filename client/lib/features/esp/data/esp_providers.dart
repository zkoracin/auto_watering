import 'package:client/core/network/api_client_provider.dart';
import 'package:client/features/esp/data/esp_repository.dart';
import 'package:client/features/esp/domain/esp_status.dart';
import 'package:client/features/esp/domain/esp_time.dart';
import 'package:client/features/esp/state/esp_status_notifier.dart';
import 'package:client/features/esp/state/esp_time_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final espRepositoryProvider = Provider<EspRepository>((ref) {
  return EspRepository(ref.watch(apiClientProvider));
});

final espStatusNotifierProvider =
    AsyncNotifierProvider<EspStatusNotifier, EspStatus>(() {
      return EspStatusNotifier();
    });

final espTimeNotifierProvider = AsyncNotifierProvider<EspTimeNotifier, EspTime>(
  () {
    return EspTimeNotifier();
  },
);
