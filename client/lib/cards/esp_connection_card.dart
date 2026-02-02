import 'package:client/models/esp_connection.dart';
import 'package:client/services/esp_service.dart';
import 'package:flutter/material.dart';

class EspConnectionCard extends StatefulWidget {
  const EspConnectionCard({super.key});

  @override
  State<EspConnectionCard> createState() => _EspConnectionCardState();
}

class _EspConnectionCardState extends State<EspConnectionCard> {
  final EspService _espService = EspService();
  EspConnectionState _state = EspConnectionState.idle;

  Future<void> _testEspConnection() async {
    setState(() => _state = EspConnectionState.testing);

    try {
      await _espService.testConnection();
      setState(() => _state = EspConnectionState.success);
    } catch (_) {
      setState(() => _state = EspConnectionState.failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _state.icon(colorScheme),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _state.buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _state == EspConnectionState.testing
                      ? null
                      : _testEspConnection,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 36),
                  ),
                  child: _state == EspConnectionState.testing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Test'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
