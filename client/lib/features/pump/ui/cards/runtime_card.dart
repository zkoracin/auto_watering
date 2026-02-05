import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeCard extends ConsumerStatefulWidget {
  const RuntimeCard({super.key});

  @override
  ConsumerState<RuntimeCard> createState() => _RuntimeCardState();
}

class _RuntimeCardState extends ConsumerState<RuntimeCard> {
  int pumpSeconds = 30;

  @override
  Widget build(BuildContext context) {
    final pumpData = ref.watch(runtimeProvider);
    final current = pumpData.value?.seconds ?? 30;
    final min = pumpData.value?.min ?? 2;
    final max = pumpData.value?.max ?? 600;

    pumpSeconds = pumpSeconds.clamp(min, max);

    return NumericSettingCard(
      title: 'Current Run Time',
      description:
          'This means that when the pump is turned on, it will run for $current seconds',
      value: pumpSeconds,
      min: min,
      max: max,
      isLoading: pumpData.isLoading,
      onIncrement: () =>
          setState(() => pumpSeconds = (pumpSeconds + 1).clamp(min, max)),
      onDecrement: () =>
          setState(() => pumpSeconds = (pumpSeconds - 1).clamp(min, max)),
      onConfirm: () {
        ref.read(runtimeProvider.notifier).updatePumpRunTime(pumpSeconds);
      },
    );
  }
}
