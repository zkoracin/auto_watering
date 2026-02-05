import 'package:flutter/material.dart';

class Schedule {
  final int hour;
  final int minute;
  final int interval;
  final int startDay;

  const Schedule({
    required this.hour,
    required this.minute,
    required this.interval,
    required this.startDay,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      hour: json['hour'] as int? ?? 1,
      minute: json['minute'] as int? ?? 1,
      interval: json['interval'] as int? ?? 1,
      startDay: json['startDay'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'interval': interval,
      'startDay': startDay,
    };
  }

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  Schedule copyWith({int? hour, int? minute, int? interval, int? startDay}) {
    return Schedule(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      interval: interval ?? this.interval,
      startDay: startDay ?? this.startDay,
    );
  }
}
