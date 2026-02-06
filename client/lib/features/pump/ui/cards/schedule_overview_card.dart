import 'package:client/shared/constants/day_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/data/pump_providers.dart';

class ScheduleOverviewCard extends ConsumerWidget {
  const ScheduleOverviewCard({super.key});

  String _formatTime(int? hour, int? minute) {
    if (hour == null || minute == null) return '--:--';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeAsync = ref.watch(scheduleTimeProvider);
    final intervalAsync = ref.watch(scheduleIntervalProvider);
    final dayAsync = ref.watch(scheduleStartDayProvider);
    final runtimeAsync = ref.watch(runtimeProvider);

    final isLoading = [
      timeAsync,
      intervalAsync,
      dayAsync,
      runtimeAsync,
    ].any((state) => state.isLoading);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pump Schedule Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Start Time: ${_formatTime(timeAsync.value?.hour, timeAsync.value?.minute)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Interval: ${intervalAsync.value?.interval ?? 0} days',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Start Day: ${dayNames[dayAsync.value?.startDay ?? 0]}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Runtime: ${runtimeAsync.value?.seconds ?? 0} seconds',
              style: const TextStyle(fontSize: 16),
            ),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
