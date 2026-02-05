import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:client/shared/constants/day_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleStartDayCard extends ConsumerStatefulWidget {
  const ScheduleStartDayCard({super.key});

  @override
  ConsumerState<ScheduleStartDayCard> createState() =>
      _ScheduleStartDayCardState();
}

class _ScheduleStartDayCardState extends ConsumerState<ScheduleStartDayCard> {
  int startDay = 1;
  final int min = 1;
  final int max = 7;

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(scheduleStartDayProvider);
    final current = data.value?.startDay ?? startDay;

    startDay = startDay.clamp(min, max);

    return NumericSettingCard(
      title: 'Pump Start Day',
      description: 'Pump will start on ${dayNames[current]}',
      value: startDay,
      min: min,
      max: max,
      isLoading: data.isLoading,
      onIncrement: () =>
          setState(() => startDay = (startDay + 1).clamp(min, max)),
      onDecrement: () =>
          setState(() => startDay = (startDay - 1).clamp(min, max)),
      onConfirm: () {
        ref
            .read(scheduleStartDayProvider.notifier)
            .updateScheduleStartDay(startDay);
      },
    );
  }
}
