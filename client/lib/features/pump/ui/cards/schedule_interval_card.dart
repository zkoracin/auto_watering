import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:client/shared/confirm_btn_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleIntervalCard extends ConsumerStatefulWidget {
  const ScheduleIntervalCard({super.key});

  @override
  ConsumerState<ScheduleIntervalCard> createState() =>
      _ScheduleIntervalCardState();
}

class _ScheduleIntervalCardState extends ConsumerState<ScheduleIntervalCard> {
  int? _draftInterval;

  void _updateDraft(int min, int max, int newValue) {
    setState(() {
      _draftInterval = newValue.clamp(min, max);
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

    final schedule = scheduleAsync.value;
    final remoteInterval = schedule?.interval;

    final min = remoteInterval?.min ?? 1;
    final max = remoteInterval?.max ?? 7;

    final currentLength = remoteInterval?.length ?? min;
    final displayValue = _draftInterval ?? currentLength;

    final isProcessing =
        scheduleAsync.isLoading ||
        (schedule?.loadingFields.contains('interval') ?? false);

    return NumericSettingCard(
      title: 'Current Scheduled Interval',
      description: 'Pump will run every $currentLength days',
      value: displayValue,
      min: min,
      max: max,
      isLoading: isProcessing,
      onIncrement: () => _updateDraft(min, max, displayValue + 1),
      onDecrement: () => _updateDraft(min, max, displayValue - 1),
      onConfirm:
          ConfirmBtnState.canConfirm(
            scheduleAsync,
            _draftInterval,
            remoteInterval?.length,
          )
          ? _confirmUpdate
          : null,
    );
  }
}
