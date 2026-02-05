class EspStatus {
  final String status;
  final String ip;

  EspStatus({required this.status, required this.ip});

  factory EspStatus.fromJson(Map<String, dynamic> json) {
    return EspStatus(
      status: json['status'] as String,
      ip: json['ip'] as String,
    );
  }
}
