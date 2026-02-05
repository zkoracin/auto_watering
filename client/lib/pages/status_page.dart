import 'package:client/features/pump/ui/buttons/power_button.dart';
import 'package:client/providers/pump_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pump = ref.watch(pumpStatusProvider);

    return Center(
      child: pump.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => const Text('Failed to load pump status'),
        data: (status) => PowerButton(
          isOn: status.pumpOn,
          onPressed: () => ref.read(pumpStatusProvider.notifier).togglePump(),
        ),
      ),
    );
  }
}
