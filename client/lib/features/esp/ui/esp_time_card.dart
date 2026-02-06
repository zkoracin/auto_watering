import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/day_names.dart';
import 'package:client/shared/constants/status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeCard extends ConsumerWidget {
  const EspTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final status = ref.watch(espTimeNotifierProvider);
    final state = status.maybeMap(
      loading: (_) => StatusState.testing,
      error: (_) => StatusState.failure,
      orElse: () => StatusState.success,
    );

    String buildText() {
      final baseText = state.text(StatusContext.espTime);
      if (state == StatusState.success && status.hasValue) {
        final day = status.value?.day ?? 0;
        final hour = status.value?.hour.toString().padLeft(2, '0') ?? '0';
        final minute = status.value?.minute.toString().padLeft(2, '0') ?? '0';
        return '$baseText : ${dayNames[day]} $hour:$minute';
      }
      return baseText;
    }

    return StatusCard(
      icon: state.icon(colorScheme, StatusContext.espTime),
      text: buildText(),
      isLoading: status.isLoading || status.isRefreshing,
      onRefresh: () => ref.read(espTimeNotifierProvider.notifier).refresh(),
    );
  }
}
