import 'package:client/features/esp/ui/connection_card.dart';
import 'package:client/features/pump/ui/cards/runtime_test_card.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                children: [ConnectionCard(), RuntimeTestCard()],
              ),
            ),
          ),
        );
      },
    );
  }
}
