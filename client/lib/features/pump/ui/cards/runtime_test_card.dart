import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/status_state.dart';
import 'package:client/shared/countdown_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeTestCard extends ConsumerWidget {
  const RuntimeTestCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final runtime = ref.watch(runtimeProvider);
    final pumpTest = ref.watch(runtimeTestProvider);
    final remainingSeconds = ref.watch(countdownProvider);

    int seconds = runtime.value?.seconds ?? 2;

    final state = pumpTest.maybeMap(
      loading: (_) => StatusState.testing,
      error: (_) => StatusState.failure,
      orElse: () =>
          remainingSeconds > 0 ? StatusState.testing : StatusState.success,
    );

    final isRunning =
        pumpTest.isLoading || remainingSeconds > 0 || runtime.isLoading;

    String btnText = 'Pump should run for $seconds seconds';
    if (!pumpTest.hasError && remainingSeconds > 0) {
      btnText = 'Pump running... $remainingSeconds s left';
    }
    if (pumpTest.hasError) {
      btnText = 'Pump test failed, cannot connect to pump';
    }
    final effectiveState = runtime.hasError ? StatusState.failure : state;
    return StatusCard(
      icon: effectiveState.icon(colorScheme, StatusContext.pump),
      text: btnText,
      isLoading: isRunning,
      onRefresh: (isRunning || pumpTest.hasError || runtime.hasError)
          ? null
          : () async {
              await ref.read(runtimeTestProvider.notifier).runTest();

              if (!ref.read(runtimeTestProvider).hasError) {
                ref.read(countdownProvider.notifier).start(seconds);
              }
            },
    );
  }
}
