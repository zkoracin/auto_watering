import 'package:client/buttons/test_button.dart';
import 'package:client/models/esp_connection.dart';
import 'package:client/providers/esp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspConnectionCard extends ConsumerWidget {
  const EspConnectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final espStatus = ref.watch(espStatusProvider);

    final icon = espStatus.isLoading
        ? EspConnectionState.testing.icon(colorScheme)
        : espStatus.hasError
        ? EspConnectionState.failure.icon(colorScheme)
        : EspConnectionState.success.icon(colorScheme);

    final buttonText = espStatus.isLoading
        ? EspConnectionState.testing.buttonText
        : espStatus.hasError
        ? EspConnectionState.failure.buttonText
        : EspConnectionState.success.buttonText;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TestButton(
              isLoading: espStatus.isLoading,
              onPressed: () => ref.read(espStatusProvider.notifier).refresh(),
            ),
          ],
        ),
      ),
    );
  }
}
