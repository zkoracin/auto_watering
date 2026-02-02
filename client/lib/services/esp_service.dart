import 'dart:convert';
import 'package:client/models/esp_status.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EspService {
  final String baseUrl;

  EspService() : baseUrl = dotenv.env['BASE_URL']!;

  Duration timeout = const Duration(seconds: 3);

  Future<EspStatus> getStatus() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/status'))
          .timeout(timeout);

      if (response.statusCode != 200) {
        throw Exception('ESP not reachable');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return EspStatus.fromJson(data);
    } catch (e) {
      throw Exception('ESP not reachable: $e');
    }
  }
}
