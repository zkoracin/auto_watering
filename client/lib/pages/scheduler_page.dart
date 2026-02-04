import 'package:client/cards/pump_run_time_card.dart';
import 'package:client/cards/pump_schedule_interval_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerPage extends ConsumerWidget {
  const SchedulerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [PumpRunTimeCard(), PumpScheduleIntervalCard()],
              ),
            ),
          ),
        );
      },
    );
  }
}
