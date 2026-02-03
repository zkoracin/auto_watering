import 'package:client/models/esp_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EspService {
  final Dio dio;
  final String baseUrl;

  EspService(this.dio) : baseUrl = dotenv.env['BASE_URL']!;

  Future<EspStatus> getStatus() async {
    final response = await dio.get<Map<String, dynamic>>('$baseUrl/status');
    return EspStatus.fromJson(response.data!);
  }
}
