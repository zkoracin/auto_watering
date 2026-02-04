class PumpRunTime {
  final int seconds;
  final int min;
  final int max;

  const PumpRunTime({
    required this.seconds,
    required this.min,
    required this.max,
  });

  factory PumpRunTime.fromJson(Map<String, dynamic> json) {
    return PumpRunTime(
      seconds: json['seconds'] as int? ?? 30,
      min: json['min'] as int? ?? 2,
      max: json['max'] as int? ?? 600,
    );
  }
}
