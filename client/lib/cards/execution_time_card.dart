import 'package:client/buttons/increment_button.dart';
import 'package:flutter/material.dart';

class ExecutionTimeCard extends StatefulWidget {
  const ExecutionTimeCard({super.key});

  @override
  State<ExecutionTimeCard> createState() => _ExecutionTimeCardState();
}

class _ExecutionTimeCardState extends State<ExecutionTimeCard> {
  int minPumpSeconds = 5;
  int maxPumpSeconds = 600;

  int pumpSeconds = 30;

  void _increment() {
    setState(() {
      pumpSeconds = (pumpSeconds++).clamp(minPumpSeconds, maxPumpSeconds);
    });
  }

  void _decrement() {
    setState(() {
      if (pumpSeconds > 1) {
        pumpSeconds--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Execution Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Device will run for $pumpSeconds Seconds',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                IncrementButton(icon: Icons.remove, onTap: _decrement),
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
                IncrementButton(icon: Icons.add, onTap: _increment),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
