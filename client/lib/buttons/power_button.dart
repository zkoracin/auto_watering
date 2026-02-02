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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: _loading ? null : _handlePressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(32),
            backgroundColor: widget.isOn
                ? colorScheme.primary
                : colorScheme.secondary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _loading
                  ? SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                        strokeWidth: 3,
                      ),
                    )
                  : Icon(
                      Icons.power_settings_new,
                      color: colorScheme.onPrimary,
                      size: 48,
                    ),
              const SizedBox(height: 8),
              Text(
                _loading
                    ? 'Processing...'
                    : widget.isOn
                    ? 'Turn OFF'
                    : 'Turn ON',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
