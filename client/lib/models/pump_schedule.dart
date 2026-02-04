import 'package:flutter/material.dart';

class PumpSchedule {
  final int hour;
  final int minute;
  final int interval;

  const PumpSchedule({
    required this.hour,
    required this.minute,
    required this.interval,
  });

  factory PumpSchedule.fromJson(Map<String, dynamic> json) {
    return PumpSchedule(
      hour: json['hour'] as int? ?? 1,
      minute: json['minute'] as int? ?? 1,
      interval: json['interval'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'hour': hour, 'minute': minute, 'interval': interval};
  }

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  PumpSchedule copyWith({int? hour, int? minute, int? interval}) {
    return PumpSchedule(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      interval: interval ?? this.interval,
    );
  }
}
