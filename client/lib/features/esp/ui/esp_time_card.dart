import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/domain/esp_connection.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/day_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspTimeCard extends ConsumerWidget {
  const EspTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final status = ref.watch(espTimeNotifierProvider);
    final state = status.maybeMap(
      loading: (_) => EspConnectionState.testing,
      error: (_) => EspConnectionState.failure,
      orElse: () => EspConnectionState.success,
    );

    String buildText() {
      final baseText = state.text(EspUiContext.time);
      if (state == EspConnectionState.success && status.hasValue) {
        final day = status.value?.day ?? 0;
        final hour = status.value?.hour.toString().padLeft(2, '0') ?? '0';
        final minute = status.value?.minute.toString().padLeft(2, '0') ?? '0';
        return '$baseText : ${dayNames[day]} $hour:$minute';
      }
      return baseText;
    }

    return StatusCard(
      icon: state.icon(colorScheme, EspUiContext.time),
      text: buildText(),
      isLoading: status.isLoading || status.isRefreshing,
      onRefresh: () => ref.read(espTimeNotifierProvider.notifier).refresh(),
    );
  }
}
