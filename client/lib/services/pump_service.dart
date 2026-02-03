import 'dart:convert';
import 'package:client/models/pump_status.dart';
import 'package:client/models/pump_execution_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PumpService {
  final String baseUrl;

  PumpService() : baseUrl = '${dotenv.env['BASE_URL']!}/pump';

  Duration timeout = const Duration(seconds: 3);

  Future<PumpStatus> fetchPumpStatus() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch pump status');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return PumpStatus.fromJson(data);
    } catch (e) {
      debugPrint('Error fetching pump status: $e');
      return const PumpStatus(pumpOn: false);
    }
  }

  Future<PumpStatus> togglePump() async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/toggle'))
          .timeout(timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to toggle pump');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return PumpStatus.fromJson(data);
    } catch (e) {
      debugPrint('Error toggling pump: $e');
      return const PumpStatus(pumpOn: false);
    }
  }

  Future<PumpExecutionTime> getPumpExecutionTime() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/time'))
          .timeout(timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch pump time');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return PumpExecutionTime.fromJson(data);
    } catch (e) {
      debugPrint('Error fetching pump time: $e');
      return const PumpExecutionTime(seconds: 0, min: 0, max: 0);
    }
  }

  Future<int> setPumpExecutionTime(int seconds) async {
    final response = await http
        .put(
          Uri.parse('$baseUrl/time'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'seconds': seconds}),
        )
        .timeout(timeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to update pump time');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['seconds'] as int;
  }
}
