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

    final hasError = runtime.hasError || pumpTest.hasError;
    final isRunning =
        runtime.isLoading || pumpTest.isLoading || remainingSeconds > 0;

    final state = hasError
        ? StatusState.failure
        : (isRunning ? StatusState.testing : StatusState.success);

    int seconds = runtime.value?.seconds ?? 2;
    String btnText = 'Pump should run for $seconds seconds';

    if (hasError) {
      btnText = 'Cannot connect to pump';
    } else if (remainingSeconds > 0) {
      btnText = 'Pump running... ${remainingSeconds}s left';
    }

    return StatusCard(
      icon: state.icon(colorScheme, StatusContext.pump),
      text: btnText,
      textColor: state == StatusState.failure ? colorScheme.error : null,
      showButton: !hasError,
      isLoading: isRunning,
      onRefresh: (isRunning || hasError)
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
