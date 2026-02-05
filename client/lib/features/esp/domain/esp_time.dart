class EspTime {
  final int day;
  final int hour;
  final int minute;

  EspTime({required this.day, required this.hour, required this.minute});

  factory EspTime.fromJson(Map<String, dynamic> json) {
    return EspTime(
      day: json['day'] as int? ?? 0,
      hour: json['hour'] as int? ?? 0,
      minute: json['minute'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'hour': hour, 'minute': minute};
  }
}
