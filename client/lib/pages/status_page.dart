import 'package:client/features/esp/ui/esp_time_card.dart';
import 'package:client/features/pump/ui/cards/schedule_overview_card.dart';
import 'package:client/shared/buttons/pump_control.dart';
import 'package:client/shared/constants/page_modes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

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
                children: [
                  EspTimeCard(mode: PageMode.status),
                  ScheduleOverviewCard(),
                  SizedBox(height: 60),
                  Center(child: PumpControl()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
