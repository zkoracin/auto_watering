import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:client/shared/buttons/increment_button.dart';
import 'package:client/shared/buttons/confirm_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleTimeCard extends ConsumerStatefulWidget {
  const ScheduleTimeCard({super.key});

  @override
  ConsumerState<ScheduleTimeCard> createState() => _ScheduleTimeCardState();
}

class _ScheduleTimeCardState extends ConsumerState<ScheduleTimeCard> {
  int? _tempHour;
  int? _tempMinute;

  Future<void> _pickTime(int initialHour, int initialMinute) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _tempHour ?? initialHour,
        minute: _tempMinute ?? initialMinute,
      ),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );

    if (pickedTime != null) {
      setState(() {
        _tempHour = pickedTime.hour;
        _tempMinute = pickedTime.minute;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final scheduleAsync = ref.watch(scheduleProvider);
    final schedule = scheduleAsync.value;

    final currentHour = schedule?.hour ?? 0;
    final currentMin = schedule?.minute ?? 0;
    final displayHour = _tempHour ?? currentHour;
    final displayMin = _tempMinute ?? currentMin;

    final isLoadingField =
        scheduleAsync.value?.loadingFields.contains('time') ?? false;

    final currentTimeText = TimeUtils.formatClockTime(currentHour, currentMin);
    final displayTimeText = TimeUtils.formatClockTime(displayHour, displayMin);

    final isTimeChanged =
        _tempHour != null &&
        (_tempHour != currentHour || _tempMinute != currentMin);

    final isBusy = scheduleAsync.isLoading || isLoadingField;
    final canSave = isTimeChanged && !isBusy;
    final hasError = scheduleAsync.hasError;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  hasError ? 'Pump start time unavailable' : 'Pump start time',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (!hasError) ...[
              const SizedBox(height: 4),
              Text(
                'Current: $currentTimeText',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        displayTimeText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IncrementButton(
                    icon: Icons.edit_calendar_outlined,
                    onTap: () => _pickTime(currentHour, currentMin),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConfirmButton(
                onPressed: !canSave
                    ? null
                    : () async {
                        await ref
                            .read(scheduleProvider.notifier)
                            .updateTime(displayHour, displayMin);
                        if (hasError) {
                          setState(() {
                            _tempHour = null;
                            _tempMinute = null;
                          });
                        }
                      },
                isLoading: isBusy,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
