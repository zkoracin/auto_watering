import 'package:client/models/pump_status.dart';
import 'package:client/notifiers/pump_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pumpStatusProvider =
    AsyncNotifierProvider<PumpStatusNotifier, PumpStatus>(
      PumpStatusNotifier.new,
    );
