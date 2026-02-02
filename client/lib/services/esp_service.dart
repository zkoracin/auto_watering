import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EspService {
  final String baseUrl;

  EspService() : baseUrl = dotenv.env['BASE_URL']!;

  Duration timeout = const Duration(seconds: 3);

  Future<void> testConnection() async {
    final response = await http.get(Uri.parse(baseUrl)).timeout(timeout);
    if (response.statusCode != 200) {
      throw Exception('ESP not reachable');
    }
  }

  Future<String> getStatus() async {
    final response = await http
        .get(Uri.parse('$baseUrl/status'))
        .timeout(timeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to get status');
    }

    return response.body;
  }
}
