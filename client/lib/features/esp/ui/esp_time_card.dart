import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/page_modes.dart';
import 'package:client/shared/constants/status_state.dart';
import 'package:client/shared/time_utils.dart';
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
      textColor: state == StatusState.failure ? colorScheme.error : null,
      showButton: state != StatusState.failure,
      btnText: mode == PageMode.status ? 'Refresh' : 'Sync',
      isLoading: statusAsync.isLoading || statusAsync.isRefreshing,
      onRefresh: () => _handleAction(ref),
    );
  }

  String _getFormattedText(StatusState state, dynamic value) {
    final baseText = state.text(StatusContext.espTime);

    if (state == StatusState.success && value != null) {
      final formatted = TimeUtils.formatDayAndTime(
        value.day,
        value.hour,
        value.minute,
      );
      return '$baseText : $formatted';
    }

    return baseText;
  }

  void _handleAction(WidgetRef ref) {
    if (mode == PageMode.status) {
      ref.invalidate(espTimeNotifierProvider);
    } else {
      ref.read(espTimeNotifierProvider.notifier).updateEspTime();
    }
  }
}
