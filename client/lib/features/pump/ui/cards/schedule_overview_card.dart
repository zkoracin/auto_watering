import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/data/pump_providers.dart';

class ScheduleOverviewCard extends ConsumerWidget {
  const ScheduleOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleTime = ref.watch(scheduleTimeProvider);
    final scheduleInterval = ref.watch(scheduleIntervalProvider);
    final runtimeState = ref.watch(runtimeProvider);

    final hour = scheduleTime.value?.hour ?? 0;
    final minute = scheduleTime.value?.minute ?? 0;
    final interval = scheduleInterval.value?.interval ?? 0;
    final runtime = runtimeState.value?.seconds ?? 0;

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
              'Start Time: ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Interval: $interval days',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Runtime: $runtime seconds',
              style: const TextStyle(fontSize: 16),
            ),

            if (scheduleTime.isLoading ||
                runtimeState.isLoading ||
                scheduleInterval.isLoading)
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
