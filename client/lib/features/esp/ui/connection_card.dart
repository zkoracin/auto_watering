import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/features/esp/domain/esp_connection.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionCard extends ConsumerWidget {
  const ConnectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final espStatus = ref.watch(espStatusNotifierProvider);
    final state = espStatus.maybeMap(
      loading: (_) => EspConnectionState.testing,
      error: (_) => EspConnectionState.failure,
      orElse: () => EspConnectionState.success,
    );

    return StatusCard(
      icon: state.icon(colorScheme, EspUiContext.status),
      text: state.text(EspUiContext.status),
      isLoading: espStatus.isLoading || espStatus.isRefreshing,
      onRefresh: () => ref.read(espStatusNotifierProvider.notifier).refresh(),
    );
  }
}
