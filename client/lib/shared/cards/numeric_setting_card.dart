import 'package:client/shared/buttons/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:client/shared/buttons/increment_button.dart';

class NumericSettingCard extends StatelessWidget {
  final String title;
  final String description;
  final int value;
  final int min;
  final int max;
  final bool isLoading;
  final VoidCallback? onConfirm;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool hasError;

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
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                  title,
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
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IncrementButton(
                    icon: Icons.remove,
                    onTap: value > min ? onDecrement : null,
                  ),
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
                  IncrementButton(
                    icon: Icons.add,
                    onTap: value < max ? onIncrement : null,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConfirmButton(isLoading: isLoading, onPressed: onConfirm),
            ],
          ],
        ),
      ),
    );
  }
}
