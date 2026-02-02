import 'package:client/buttons/power_button.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final PumpService _pumpService = PumpService();
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
      final status = await _pumpService.fetchPumpStatus();
      setState(() {
        _pumpOn = status.pumpOn;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Failed to load pump status: $e');
      setState(() => _loading = false);
    }
  }

  Future<void> _togglePump() async {
    setState(() => _loading = true);

    try {
      final statusDto = await _pumpService.togglePump();
      setState(() {
        _pumpOn = statusDto.pumpOn;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Failed to toggle pump: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading
          ? const CircularProgressIndicator()
          : PowerButton(
              isOn: _pumpOn,
              onPressed: () async {
                _togglePump();
              },
            ),
    );
  }
}
