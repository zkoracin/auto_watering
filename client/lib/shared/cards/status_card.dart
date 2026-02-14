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

  final Widget icon;
  final String text;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 400;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isSmallScreen
            ? _buildVerticalLayout(theme)
            : _buildHorizontalLayout(theme),
      ),
    );
  }

  Widget _buildHorizontalLayout(ThemeData theme) {
    return Row(
      children: [
        _buildIcon(theme),
        const SizedBox(width: 16),
        Expanded(child: _buildText(theme)),
        const SizedBox(width: 8),
        _buildButton(),
      ],
    );
  }

  Widget _buildVerticalLayout(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _buildIcon(theme),
            const SizedBox(width: 16),
            Expanded(child: _buildText(theme)),
          ],
        ),
        const SizedBox(height: 16),
        _buildButton(),
      ],
    );
  }

  Widget _buildIcon(ThemeData theme) => IconTheme(
    data: IconThemeData(color: theme.colorScheme.primary, size: 24),
    child: icon,
  );

  Widget _buildText(ThemeData theme) => Text(
    text,
    style: theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    ),
  );

  Widget _buildButton() => SizedBox(
    width: 100,
    child: TestButton(
      isLoading: isLoading,
      onPressed: onRefresh,
      btnText: btnText,
    ),
  );
}
