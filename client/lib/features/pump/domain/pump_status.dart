class PumpStatus {
  final bool pumpOn;

  const PumpStatus({required this.pumpOn});

  factory PumpStatus.fromJson(Map<String, dynamic> json) {
    return PumpStatus(pumpOn: json['pumpOn'] as bool? ?? false);
  }
}
