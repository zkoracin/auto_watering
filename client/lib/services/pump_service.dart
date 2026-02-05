import 'package:client/models/pump_run_time_test.dart';
import 'package:client/models/pump_schedule.dart';
import 'package:client/models/pump_status.dart';
import 'package:client/models/pump_run_time.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PumpService {
  final Dio dio;
  final String baseUrl;

  PumpService(this.dio) : baseUrl = '${dotenv.env['BASE_URL']!}/pump';

  Future<PumpStatus> getPumpStatus() async {
    final response = await dio.get<Map<String, dynamic>>(baseUrl);
    return PumpStatus.fromJson(response.data!);
  }

  Future<PumpStatus> togglePump() async {
    final response = await dio.post<Map<String, dynamic>>('$baseUrl/toggle');
    return PumpStatus.fromJson(response.data!);
  }

  Future<PumpRunTime> getPumpRunTime() async {
    final response = await dio.get<Map<String, dynamic>>('$baseUrl/runtime');
    return PumpRunTime.fromJson(response.data!);
  }

  Future<PumpRunTime> updatePumpRunTime(int seconds) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/runtime',
      data: {'seconds': seconds},
    );
    return PumpRunTime.fromJson(response.data!);
  }

  Future<PumpRuntimeTestResponse> testPumpRunTime() async {
    final response = await dio.post('$baseUrl/runtime-test');
    return PumpRuntimeTestResponse.fromJson(response.data!);
  }

  Future<PumpSchedule> getPumpSchedule() async {
    final response = await dio.get<Map<String, dynamic>>('$baseUrl/schedule');
    return PumpSchedule.fromJson(response.data!);
  }

  Future<PumpSchedule> updatePumpSchedule(PumpSchedule schedule) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/schedule',
      data: schedule.toJson(),
    );
    return PumpSchedule.fromJson(response.data!);
  }
}
