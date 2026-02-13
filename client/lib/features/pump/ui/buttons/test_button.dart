import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestButton extends ConsumerWidget {
  const TestButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.btnText = 'Test',
  });

  final bool isLoading;
  final VoidCallback onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size(80, 36)),
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(btnText),
    );
  }
}
