import 'package:client/cards/numeric_setting_card.dart';
import 'package:client/providers/pump_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpScheduleIntervalCard extends ConsumerStatefulWidget {
  const PumpScheduleIntervalCard({super.key});

  @override
  ConsumerState<PumpScheduleIntervalCard> createState() =>
      _PumpPumpScheduleIntervalCardState();
}

class _PumpPumpScheduleIntervalCardState
    extends ConsumerState<PumpScheduleIntervalCard> {
  int interval = 2;
  int min = 1;
  int max = 14;

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(pumpScheduleIntervalProvider);
    final current = data.value?.interval ?? interval;

    interval = interval.clamp(min, max);

    return NumericSettingCard(
      title: 'Current Scheduled Interval',
      description: 'Pump will run every $current days',
      value: interval,
      min: min,
      max: max,
      isLoading: data.isLoading,
      onIncrement: () =>
          setState(() => interval = (interval + 1).clamp(min, max)),
      onDecrement: () =>
          setState(() => interval = (interval - 1).clamp(min, max)),
      onConfirm: () {
        ref
            .read(pumpScheduleIntervalProvider.notifier)
            .updateScheduleInterval(interval);
      },
    );
  }
}
