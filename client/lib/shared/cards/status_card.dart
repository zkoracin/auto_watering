import 'package:client/features/pump/ui/buttons/test_button.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.icon,
    required this.text,
    required this.isLoading,
    required this.onRefresh,
    this.btnText = 'Test',
  });

  final Icon icon;
  final String text;
  final bool isLoading;
  final VoidCallback onRefresh;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TestButton(
              isLoading: isLoading,
              onPressed: onRefresh,
              btnText: btnText,
            ),
          ],
        ),
      ),
    );
  }
}
