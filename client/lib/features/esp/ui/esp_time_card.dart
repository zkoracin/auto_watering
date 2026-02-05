import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/shared/constants/day_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeCard extends ConsumerWidget {
  const EspTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(espTimeNotifierProvider);
    final day = time.value?.day ?? 0;
    final hour = time.value?.hour.toString().padLeft(2, '0') ?? '0';
    final minute = time.value?.minute.toString().padLeft(2, '0') ?? '0';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Time on the ESP: ${dayNames[day]} $hour:$minute',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
