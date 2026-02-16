import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:client/shared/confirm_btn_state.dart';
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
    await ref.read(scheduleProvider.notifier).updateStartDay(valueToSave);
    if (mounted) {
      setState(() => _draftDay = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(scheduleProvider);
    final remoteDay = scheduleAsync.value?.startDay;
    final displayValue = _draftDay ?? remoteDay ?? _min;
    final isLoading =
        scheduleAsync.value?.loadingFields.contains('startDay') ?? false;

    final hasError = scheduleAsync.hasError;

    return NumericSettingCard(
      title: hasError ? 'Pump start day unavailable' : 'Pump Start Day',
      description: 'Pump will start on ${dayNames[remoteDay ?? _min]}',
      value: displayValue,
      min: _min,
      max: _max,
      isLoading: scheduleAsync.isLoading || isLoading,
      hasError: hasError,
      onIncrement: () => _updateDraft(displayValue + 1),
      onDecrement: () => _updateDraft(displayValue - 1),
      onConfirm: ConfirmBtnState.canConfirm(scheduleAsync, _draftDay, remoteDay)
          ? _confirmUpdate
          : null,
    );
  }
}
