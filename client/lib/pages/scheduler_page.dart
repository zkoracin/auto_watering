import 'package:client/cards/scheduler_card.dart';
import 'package:client/models/pump_execution_time.dart';
import 'package:client/services/pump_service.dart';
import 'package:flutter/material.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  final PumpService _pumpService = PumpService();

  PumpExecutionTime? _pumpTime;
  bool _loadingPumpTime = true;

  @override
  void initState() {
    super.initState();
    _loadPumpTime();
  }

  Future<void> _loadPumpTime() async {
    setState(() => _loadingPumpTime = true);
    try {
      final response = await _pumpService.getPumpExecutionTime();
      setState(() {
        _pumpTime = response;
        _loadingPumpTime = false;
      });
    } catch (e) {
      debugPrint('Failed to load pump time: $e');
      setState(() => _loadingPumpTime = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_loadingPumpTime)
                    const CircularProgressIndicator()
                  else
                    SchedulerCard(pumpRunTime: _pumpTime?.seconds ?? 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
