import 'package:client/core/network/api_client_provider.dart';
import 'package:client/features/pump/data/pump_repository.dart';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/features/pump/state/runtime_notifier.dart';
import 'package:client/features/pump/state/runtime_test_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpRepositoryProvider = Provider<PumpRepository>((ref) {
  return PumpRepository(ref.watch(apiClientProvider));
});

final runtimeProvider = AsyncNotifierProvider<RuntimeNotifier, Runtime>(
  RuntimeNotifier.new,
);

final runtimeTestProvider =
    AsyncNotifierProvider<RuntimeTestNotifier, RuntimeTest>(
      RuntimeTestNotifier.new,
    );
