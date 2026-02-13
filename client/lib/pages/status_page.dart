import 'package:client/features/esp/ui/esp_time_card.dart';
import 'package:client/features/pump/ui/buttons/power_button.dart';
import 'package:client/features/pump/ui/cards/schedule_overview_card.dart';
import 'package:client/shared/constants/page_modes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/pump/data/pump_providers.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpState = ref.watch(pumpStatusProvider);

    Widget pumpWidget;
    if (pumpState.isLoading) {
      pumpWidget = const CircularProgressIndicator();
    } else if (pumpState.hasError) {
      pumpWidget = const Text('Failed to load pump status');
    } else {
      final status = pumpState.value!;
      pumpWidget = PowerButton(
        isOn: status.pumpOn,
        onPressed: () => ref.read(pumpStatusProvider.notifier).togglePump(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const EspTimeCard(mode: PageMode.status),
                  const ScheduleOverviewCard(),
                  const SizedBox(height: 60),
                  Center(child: pumpWidget),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
