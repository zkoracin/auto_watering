import 'package:flutter/material.dart';

class Interval {
  final int length;
  final int min;
  final int max;

  const Interval({required this.length, required this.min, required this.max});

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
      length: json['length'] as int? ?? 1,
      min: json['min'] as int? ?? 1,
      max: json['max'] as int? ?? 7,
    );
  }

  Interval copyWith({int? length, int? min, int? max}) {
    return Interval(
      length: length ?? this.length,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}

class Schedule {
  final int hour;
  final int minute;
  final Interval interval;
  final int startDay;
  final Set<String> loadingFields;

  const Schedule({
    required this.hour,
    required this.minute,
    required this.interval,
    required this.startDay,
    this.loadingFields = const {},
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      hour: json['hour'] as int? ?? 1,
      minute: json['minute'] as int? ?? 1,
      startDay: json['startDay'] as int? ?? 1,
      interval: json['interval'] != null
          ? Interval.fromJson(json['interval'])
          : const Interval(length: 1, min: 1, max: 7),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'intervalLength': interval.length,
      'startDay': startDay,
    };
  }

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  Schedule copyWith({
    int? hour,
    int? minute,
    int? intervalLength,
    int? startDay,
    Set<String>? loadingFields,
  }) {
    return Schedule(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      interval: intervalLength != null
          ? interval.copyWith(length: intervalLength)
          : interval,
      startDay: startDay ?? this.startDay,
      loadingFields: loadingFields ?? this.loadingFields,
    );
  }
}
