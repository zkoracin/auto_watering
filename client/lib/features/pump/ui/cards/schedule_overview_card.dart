import 'package:client/shared/constants/day_names.dart';
import 'package:client/shared/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/data/pump_providers.dart';

class ScheduleOverviewCard extends ConsumerWidget {
  const ScheduleOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(scheduleProvider);
    final runtimeAsync = ref.watch(runtimeProvider);

    final isLoading = [
      scheduleAsync,
      runtimeAsync,
    ].any((state) => state.isLoading);

    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
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
                'Start Time: ${TimeUtils.formatClockTime(scheduleAsync.value?.hour, scheduleAsync.value?.minute)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Interval: ${scheduleAsync.value?.interval.length ?? 0} days',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Start Day: ${dayNames[scheduleAsync.value?.startDay ?? 0]}',
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
      ),
    );
  }
}
