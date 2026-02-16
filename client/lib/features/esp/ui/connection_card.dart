import 'package:client/features/esp/data/esp_providers.dart';
import 'package:client/shared/cards/status_card.dart';
import 'package:client/shared/constants/status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionCard extends ConsumerWidget {
  const ConnectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final espStatus = ref.watch(espStatusNotifierProvider);
    final state = espStatus.maybeMap(
      loading: (_) => StatusState.testing,
      error: (_) => StatusState.failure,
      orElse: () => StatusState.success,
    );

    return StatusCard(
      icon: state.icon(colorScheme, StatusContext.espConnection),
      text: state.text(StatusContext.espConnection),
      textColor: state == StatusState.failure ? colorScheme.error : null,
      showButton: true,
      isLoading: espStatus.isLoading || espStatus.isRefreshing,
      onRefresh: () => ref.read(espStatusNotifierProvider.notifier).refresh(),
    );
  }
}
