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
  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();
    final schedule = ref.read(scheduleTimeProvider).value;
    hour = schedule?.hour ?? 0;
    minute = schedule?.minute ?? 0;
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );

    if (pickedTime != null) {
      setState(() {
        hour = pickedTime.hour;
        minute = pickedTime.minute;
      });
    }
  }

  void _confirm() {
    ref.read(scheduleTimeProvider.notifier).updateScheduleTime(hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    final intervalData = ref.watch(scheduleTimeProvider);

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
              'Select the time when the pump should start '
              '${hour.toString().padLeft(2, '0')}:'
              '${minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IncrementButton(icon: Icons.add, onTap: _pickTime),
              ],
            ),
            const SizedBox(height: 16),
            ConfirmButton(
              isLoading: intervalData.isLoading,
              onPressed: _confirm,
            ),
          ],
        ),
      ),
    );
  }
}
