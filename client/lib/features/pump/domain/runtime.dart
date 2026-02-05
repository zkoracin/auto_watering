class Runtime {
  final int seconds;
  final int min;
  final int max;

  const Runtime({required this.seconds, required this.min, required this.max});

  factory Runtime.fromJson(Map<String, dynamic> json) {
    return Runtime(
      seconds: json['seconds'] as int? ?? 30,
      min: json['min'] as int? ?? 2,
      max: json['max'] as int? ?? 600,
    );
  }
}
