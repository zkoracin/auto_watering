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
  static const int _min = 1;
  static const int _max = 7;
  int? _draftDay;

  void _updateDraft(int newValue) {
    setState(() {
      _draftDay = newValue.clamp(_min, _max);
    });
  }

  void _confirmUpdate() async {
    if (_draftDay == null) return;
    final valueToSave = _draftDay!;
    await ref
        .read(scheduleStartDayProvider.notifier)
        .updateScheduleStartDay(valueToSave);
    if (mounted) {
      setState(() => _draftDay = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(scheduleStartDayProvider);
    final remoteDay = scheduleAsync.value?.startDay;
    final displayValue = _draftDay ?? remoteDay ?? _min;

    return NumericSettingCard(
      title: 'Pump Start Day',
      description: 'Pump will start on ${dayNames[remoteDay ?? _min]}',
      value: displayValue,
      min: _min,
      max: _max,
      isLoading: scheduleAsync.isLoading,
      onIncrement: () => _updateDraft(displayValue + 1),
      onDecrement: () => _updateDraft(displayValue - 1),
      onConfirm: () => _confirmUpdate(),
    );
  }
}
