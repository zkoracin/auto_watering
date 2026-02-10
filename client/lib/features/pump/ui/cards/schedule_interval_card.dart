import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleIntervalCard extends ConsumerStatefulWidget {
  const ScheduleIntervalCard({super.key});

  @override
  ConsumerState<ScheduleIntervalCard> createState() =>
      _ScheduleIntervalCardState();
}

class _ScheduleIntervalCardState extends ConsumerState<ScheduleIntervalCard> {
  static const int _minInterval = 1;
  static const int _maxInterval = 14;
  int? _draftInterval;

  void _updateDraft(int newValue) {
    setState(() {
      _draftInterval = newValue.clamp(_minInterval, _maxInterval);
    });
  }

  void _confirmUpdate() async {
    if (_draftInterval == null) return;
    final valueToSave = _draftInterval!;
    await ref.read(scheduleProvider.notifier).updateInterval(valueToSave);
    if (mounted) {
      setState(() => _draftInterval = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(scheduleProvider);
    final remoteInterval = scheduleAsync.value?.interval;
    final displayValue = _draftInterval ?? remoteInterval ?? _minInterval;
    final isLoading =
        scheduleAsync.value?.loadingFields.contains('interval') ?? false;

    return NumericSettingCard(
      title: 'Current Scheduled Interval',
      description: 'Pump will run every ${remoteInterval ?? _minInterval} days',
      value: displayValue,
      min: _minInterval,
      max: _maxInterval,
      isLoading: scheduleAsync.isLoading || isLoading,
      onIncrement: () => _updateDraft(displayValue + 1),
      onDecrement: () => _updateDraft(displayValue - 1),
      onConfirm: _confirmUpdate,
    );
  }
}
