class PumpExecutionTime {
  final int seconds;
  final int min;
  final int max;

  const PumpExecutionTime({
    required this.seconds,
    required this.min,
    required this.max,
  });

  factory PumpExecutionTime.fromJson(Map<String, dynamic> json) {
    return PumpExecutionTime(
      seconds: json['seconds'] as int? ?? 0,
      min: json['min'] as int? ?? 0,
      max: json['max'] as int? ?? 0,
    );
  }
}
