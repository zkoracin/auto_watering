import 'package:client/buttons/power_button.dart';
import 'package:client/providers/pump_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pump = ref.watch(pumpStatusProvider);

    return Center(
      child: pump.isLoading
          ? const CircularProgressIndicator()
          : PowerButton(
              isOn: pump.value?.pumpOn ?? false,
              onPressed: () =>
                  ref.read(pumpStatusProvider.notifier).togglePump(),
            ),
    );
  }
}
