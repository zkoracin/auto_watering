import 'package:client/features/pump/data/pump_providers.dart';
import 'package:client/shared/cards/numeric_setting_card.dart';
import 'package:client/shared/confirm_btn_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeCard extends ConsumerStatefulWidget {
  const RuntimeCard({super.key});

  @override
  ConsumerState<RuntimeCard> createState() => _RuntimeCardState();
}

class _RuntimeCardState extends ConsumerState<RuntimeCard> {
  int? _draftRuntime;

  void _updateDraft(int min, int max, int newValue) {
    setState(() {
      _draftRuntime = newValue.clamp(min, max);
    });
  }

  void _confirmUpdate() async {
    if (_draftRuntime == null) return;
    final valueToSave = _draftRuntime!;
    await ref.read(runtimeProvider.notifier).updateRuntime(valueToSave);
    if (mounted) {
      setState(() => _draftRuntime = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final runtimeAsync = ref.watch(runtimeProvider);
    final runtime = runtimeAsync.value;
    final remoteRuntime = runtime?.seconds;
    final remoteMin = runtime?.min ?? 2;
    final remoteMax = runtime?.max ?? 14;
    final displayValue = _draftRuntime ?? remoteRuntime ?? remoteMin;
    final hasError = runtimeAsync.hasError;

    return NumericSettingCard(
      title: hasError ? 'Runtime unavailable' : 'Current runtime',
      description:
          'This means that when the pump is turned on, it will run for ${remoteRuntime ?? remoteMin} seconds',
      value: displayValue,
      min: remoteMin,
      max: remoteMax,
      hasError: hasError,
      isLoading: runtimeAsync.isLoading,
      onIncrement: () => _updateDraft(remoteMin, remoteMax, (displayValue + 1)),
      onDecrement: () => _updateDraft(remoteMin, remoteMax, (displayValue - 1)),
      onConfirm:
          ConfirmBtnState.canConfirm(runtimeAsync, _draftRuntime, remoteRuntime)
          ? _confirmUpdate
          : null,
    );
  }
}
