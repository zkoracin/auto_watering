import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/ui/buttons/power_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpControl extends ConsumerWidget {
  const PumpControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpState = ref.watch(pumpStatusProvider);

    return pumpState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
          SizedBox(height: 8),
          Text(
            'Connection Issue, Test Esp connection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      data: (status) => PowerButton(
        isOn: status.pumpOn,
        onPressed: () => ref.read(pumpStatusProvider.notifier).togglePump(),
      ),
    );
  }
}
