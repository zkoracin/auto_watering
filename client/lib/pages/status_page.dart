import 'package:client/buttons/power_button.dart';
import 'package:client/services/esp_service.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final EspService _espService = EspService();
  bool _pumpOn = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPumpStatus();
  }

  Future<void> _loadPumpStatus() async {
    setState(() => _loading = true);
    try {
      final status = await _espService.fetchPumpStatus();
      setState(() {
        _pumpOn = status;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Failed to load pump status: $e');
      setState(() => _loading = false);
    }
  }

  void _togglePump() {
    setState(() => _pumpOn = !_pumpOn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading
          ? const CircularProgressIndicator()
          : PowerButton(
              isOn: _pumpOn,
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1));
                _togglePump();
              },
            ),
    );
  }
}
