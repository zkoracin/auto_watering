import 'package:client/models/esp_status.dart';
import 'package:client/notifiers/esp_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final espStatusProvider = AsyncNotifierProvider<EspStatusNotifier, EspStatus>(
  EspStatusNotifier.new,
);
