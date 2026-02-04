import 'package:client/buttons/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:client/buttons/increment_button.dart';

class NumericSettingCard extends StatelessWidget {
  final String title;
  final String description;
  final int value;
  final int min;
  final int max;
  final bool isLoading;
  final VoidCallback onConfirm;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const NumericSettingCard({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.min,
    required this.max,
    required this.isLoading,
    required this.onConfirm,
    required this.onIncrement,
    required this.onDecrement,
  });

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
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IncrementButton(icon: Icons.remove, onTap: onDecrement),
                const SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Text(
                      value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IncrementButton(icon: Icons.add, onTap: onIncrement),
              ],
            ),
            const SizedBox(height: 16),
            ConfirmButton(isLoading: isLoading, onPressed: onConfirm),
          ],
        ),
      ),
    );
  }
}
