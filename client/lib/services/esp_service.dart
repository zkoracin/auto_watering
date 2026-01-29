import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EspService {
  final String baseUrl;

  EspService() : baseUrl = dotenv.env['BASE_URL']!;

  Future<String> getRoot() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to connect to ESP8266');
    }

    return response.body;
  }

  Future<String> getStatus() async {
    final response = await http.get(Uri.parse('$baseUrl/status'));

    if (response.statusCode != 200) {
      throw Exception('Failed to get status');
    }

    return response.body;
  }
}
