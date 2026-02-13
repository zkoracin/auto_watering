import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/day_names.dart';
import 'package:client/shared/constants/page_modes.dart';
import 'package:client/shared/constants/status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeCard extends ConsumerWidget {
  const EspTimeCard({super.key, required this.mode});

  final PageMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusAsync = ref.watch(espTimeNotifierProvider);
    final state = statusAsync.maybeMap(
      loading: (_) => StatusState.testing,
      error: (_) => StatusState.failure,
      orElse: () => StatusState.success,
    );

    final displayText = _getFormattedText(state, statusAsync.value);

    return StatusCard(
      icon: state.icon(colorScheme, StatusContext.espTime),
      text: displayText,
      btnText: mode == PageMode.status ? 'Refresh' : 'Sync',
      isLoading: statusAsync.isLoading || statusAsync.isRefreshing,
      onRefresh: () => _handleAction(ref),
    );
  }

  String _getFormattedText(StatusState state, dynamic value) {
    final baseText = state.text(StatusContext.espTime);

    if (state == StatusState.success && value != null) {
      final day = value.day ?? 1;
      final hour = value.hour.toString().padLeft(2, '0');
      final minute = value.minute.toString().padLeft(2, '0');
      return '$baseText : ${dayNames[day]} $hour:$minute';
    }

    return baseText;
  }

  void _handleAction(WidgetRef ref) {
    final notifier = ref.read(espTimeNotifierProvider.notifier);
    if (mode == PageMode.status) {
      notifier.refresh();
    } else {
      notifier.updateEspTime();
    }
  }
}
