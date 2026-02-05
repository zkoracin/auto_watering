import 'dart:async';

import 'package:client/buttons/test_button.dart';
import 'package:client/providers/pump_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpRuntimeTestCard extends ConsumerStatefulWidget {
  const PumpRuntimeTestCard({super.key});

  @override
  ConsumerState<PumpRuntimeTestCard> createState() =>
      _PumpRuntimeTestCardState();
}

class _PumpRuntimeTestCardState extends ConsumerState<PumpRuntimeTestCard> {
  Timer? _timer;
  int _remainingSeconds = 0;

  void _startCountdown(int seconds) {
    _timer?.cancel();
    setState(() => _remainingSeconds = seconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() => _remainingSeconds = 0);
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runtime = ref.watch(pumpRunTimeProvider);
    final pumpTest = ref.watch(pumpRuntimeTestProvider);

    int seconds = runtime.value?.seconds ?? 2;

    final isLoading = pumpTest.isLoading || _remainingSeconds > 0;

    String btnText = 'Pump should run for $seconds seconds';
    if (!pumpTest.hasError && _remainingSeconds > 0) {
      btnText = 'Pump running... $_remainingSeconds s left';
    }
    if (pumpTest.hasError) {
      btnText = 'Pump test failed, cannot connect to pump';
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                btnText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TestButton(
              isLoading: isLoading,
              onPressed: () async {
                await ref.read(pumpRuntimeTestProvider.notifier).runTest();
                final updatedPumpTest = ref.read(pumpRuntimeTestProvider);
                if (!updatedPumpTest.hasError) {
                  _startCountdown(seconds);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
