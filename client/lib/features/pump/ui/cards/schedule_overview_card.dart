import 'package:client/shared/constants/day_names.dart';
import 'package:client/shared/text_utils.dart';
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

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final bool isLoading = scheduleAsync.isLoading || runtimeAsync.isLoading;
    final bool hasError = scheduleAsync.hasError || runtimeAsync.hasError;
    final bool hasData =
        scheduleAsync.hasValue && runtimeAsync.hasValue && !hasError;

    final intervalDays = scheduleAsync.value?.interval.length ?? 0;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hasError
                    ? 'Pump Schedule Overview Not Available'
                    : 'Pump Schedule Overview',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasError
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),

              if (hasData) ...[
                const SizedBox(height: 4),
                Text(
                  'The pump will run at '
                  '${TimeUtils.formatClockTime(scheduleAsync.value?.hour, scheduleAsync.value?.minute)}, '
                  '${TextUtils.formatInterval(intervalDays)}, '
                  'for ${runtimeAsync.value?.seconds ?? 0} seconds.',
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  label: 'Start Time',
                  value: TimeUtils.formatClockTime(
                    scheduleAsync.value?.hour,
                    scheduleAsync.value?.minute,
                  ),
                  textTheme: textTheme,
                ),
                const Divider(height: 24, thickness: 1),
                _InfoRow(
                  label: 'Interval',
                  value: TextUtils.capitalize(intervalDays.toString()),
                  textTheme: textTheme,
                ),
                const Divider(height: 24, thickness: 1),
                _InfoRow(
                  label: 'Start Day',
                  value: dayNames[scheduleAsync.value?.startDay ?? 0],
                  textTheme: textTheme,
                ),
                const Divider(height: 24, thickness: 1),
                _InfoRow(
                  label: 'Runtime',
                  value: '${runtimeAsync.value?.seconds ?? 0} seconds',
                  textTheme: textTheme,
                ),
              ],

              if (isLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: LinearProgressIndicator(
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextTheme textTheme;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyMedium),
          Text(value, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}
