import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/features/pump/ui/buttons/power_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PumpControl extends ConsumerWidget {
  const PumpControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpState = ref.watch(pumpStatusProvider);
    final theme = Theme.of(context);

    return pumpState.when(
      loading: () => const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => _ErrorState(theme: theme),
      data: (status) => PowerButton(
        isOn: status.pumpOn,
        onPressed: () => ref.read(pumpStatusProvider.notifier).togglePump(),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final ThemeData theme;
  const _ErrorState({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.signal_wifi_off_rounded,
            color: theme.colorScheme.error,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            'No Connection',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 4),
          const Text('Test ESP32 connection', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
