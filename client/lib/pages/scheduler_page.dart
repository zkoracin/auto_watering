import 'package:client/cards/execution_time_card.dart';
import 'package:flutter/material.dart';

class SchedulerPage extends StatelessWidget {
  const SchedulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ExecutionTimeCard()],
              ),
            ),
          ),
        );
      },
    );
  }
}
