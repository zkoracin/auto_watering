import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;

  const ConfirmButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.text = 'Confirm',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(text),
      ),
    );
  }
}
