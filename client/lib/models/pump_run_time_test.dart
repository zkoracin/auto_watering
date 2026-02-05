class PumpRuntimeTestResponse {
  final bool pumpOn;
  final int seconds;

  const PumpRuntimeTestResponse({required this.pumpOn, required this.seconds});

  factory PumpRuntimeTestResponse.fromJson(Map<String, dynamic> json) {
    return PumpRuntimeTestResponse(
      pumpOn: json['pumpOn'] as bool? ?? false,
      seconds: json['seconds'] as int? ?? 0,
    );
  }
}
