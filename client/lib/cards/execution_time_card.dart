import 'package:client/buttons/increment_button.dart';
import 'package:client/providers/pump_execution_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExecutionTimeCard extends ConsumerStatefulWidget {
  const ExecutionTimeCard({super.key});

  @override
  ConsumerState<ExecutionTimeCard> createState() => _ExecutionTimeCardState();
}

class _ExecutionTimeCardState extends ConsumerState<ExecutionTimeCard> {
  int pumpSeconds = 30;

  void _increment(int min, int max) {
    setState(() {
      pumpSeconds = (pumpSeconds + 1).clamp(min, max);
    });
  }

  void _decrement(int min, int max) {
    setState(() {
      pumpSeconds = (pumpSeconds - 1).clamp(min, max);
    });
  }

  void _confirm() {
    ref
        .read(pumpExecutionTimeProvider.notifier)
        .updateExecutionTime(pumpSeconds);
  }

  @override
  Widget build(BuildContext context) {
    final pumpData = ref.watch(pumpExecutionTimeProvider);
    final currentTime = pumpData.value?.seconds ?? 30;
    final min = pumpData.value?.min ?? 2;
    final max = pumpData.value?.max ?? 600;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Execution Time: $currentTime seconds',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'This means that when the pump is turned on, it will run for $currentTime seconds',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                IncrementButton(
                  icon: Icons.remove,
                  onTap: () => _decrement(min, max),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Text(
                      pumpSeconds.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IncrementButton(
                  icon: Icons.add,
                  onTap: () => _increment(min, max),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pumpData.isLoading ? null : _confirm,
                child: pumpData.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
