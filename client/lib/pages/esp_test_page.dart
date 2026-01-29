import 'package:client/services/esp_service.dart';
import 'package:flutter/material.dart';

class EspTestPage extends StatefulWidget {
  const EspTestPage({super.key});

  @override
  State<EspTestPage> createState() => _EspTestPageState();
}

class _EspTestPageState extends State<EspTestPage> {
  late final EspService esp = EspService();
  String output = 'Idle...';
  bool loading = false;

  Future<void> callRoot() async {
    setState(() {
      loading = true;
      output = 'Connecting...';
    });

    try {
      final result = await esp.getRoot();
      setState(() => output = result);
    } catch (e) {
      setState(() => output = 'Error: $e');
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> callStatus() async {
    setState(() {
      loading = true;
      output = 'Loading status...';
    });

    try {
      final result = await esp.getStatus();
      setState(() => output = result);
    } catch (e) {
      setState(() => output = 'Error: $e');
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESP8266 Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: loading ? null : callRoot,
              child: const Text('Call /'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading ? null : callStatus,
              child: const Text('Call /status'),
            ),
            const SizedBox(height: 16),
            Text(output, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
