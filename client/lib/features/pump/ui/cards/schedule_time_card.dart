import 'package:client/features/pump/data/pump_providers.dart';
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
    final scheduleAsync = ref.watch(scheduleProvider);
    final currentHour = scheduleAsync.value?.hour ?? 0;
    final currentMin = scheduleAsync.value?.minute ?? 0;
    final displayHour = _tempHour ?? currentHour;
    final displayMin = _tempMinute ?? currentMin;
    final isLoading =
        scheduleAsync.value?.loadingFields.contains('time') ?? false;

    final currentTimeText =
        '${currentHour.toString().padLeft(2, '0')}:${currentMin.toString().padLeft(2, '0')}';

    final displayTimeText =
        '${displayHour.toString().padLeft(2, '0')}:${displayMin.toString().padLeft(2, '0')}';

    final bool isTimeChanged =
        _tempHour != null &&
        (_tempHour != currentHour || _tempMinute != currentMin);
    final bool isBusy = scheduleAsync.isLoading || isLoading;
    final bool canSave = isTimeChanged && !isBusy && !scheduleAsync.hasError;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pump Start Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
                      setState(() {
                        _tempHour = null;
                        _tempMinute = null;
                      });
                    },
              isLoading: isBusy,
            ),
          ],
        ),
      ),
    );
  }
}
