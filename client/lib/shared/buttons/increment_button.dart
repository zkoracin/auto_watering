import 'package:flutter/material.dart';

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      style: Theme.of(context).iconButtonTheme.style,
    );
  }
}
