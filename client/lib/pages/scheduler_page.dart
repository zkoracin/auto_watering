import 'package:client/cards/scheduler_card.dart';
import 'package:client/providers/pump_execution_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerPage extends ConsumerWidget {
  const SchedulerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exeTime = ref.watch(pumpExecutionTimeProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (exeTime.isLoading)
                    const CircularProgressIndicator()
                  else
                    SchedulerCard(pumpRunTime: exeTime.value?.seconds ?? 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
