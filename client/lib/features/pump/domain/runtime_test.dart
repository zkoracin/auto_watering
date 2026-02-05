class RuntimeTest {
  final bool pumpOn;
  final int seconds;

  const RuntimeTest({required this.pumpOn, required this.seconds});

  factory RuntimeTest.fromJson(Map<String, dynamic> json) {
    return RuntimeTest(
      pumpOn: json['pumpOn'] as bool? ?? false,
      seconds: json['seconds'] as int? ?? 0,
    );
  }
}
