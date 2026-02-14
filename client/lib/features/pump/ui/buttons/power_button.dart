import 'package:flutter/material.dart';

class PowerButton extends StatefulWidget {
  const PowerButton({super.key, required this.isOn, required this.onPressed});

  final bool isOn;
  final Future<void> Function() onPressed;

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  bool _loading = false;

  Future<void> _handlePressed() async {
    setState(() => _loading = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = widget.isOn
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: ElevatedButton(
            onPressed: _loading ? null : _handlePressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: baseColor,
              disabledBackgroundColor: baseColor.withValues(alpha: 0.6),
              elevation: _loading ? 0 : 4,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_loading)
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary,
                      strokeWidth: 2,
                    ),
                  ),
                Opacity(
                  opacity: _loading ? 0.3 : 1.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.power_settings_new,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.isOn ? 'OFF' : 'ON',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _loading
              ? 'Communicating with ESP32...'
              : 'Pump is ${widget.isOn ? 'Running' : 'Stopped'}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
