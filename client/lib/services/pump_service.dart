import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/features/pump/domain/pump_status.dart';
import 'package:client/features/pump/domain/runtime.dart';
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

  Future<Runtime> getPumpRunTime() async {
    final response = await dio.get<Map<String, dynamic>>('$baseUrl/runtime');
    return Runtime.fromJson(response.data!);
  }

  Future<Runtime> updatePumpRunTime(int seconds) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/runtime',
      data: {'seconds': seconds},
    );
    return Runtime.fromJson(response.data!);
  }

  Future<RuntimeTest> testPumpRunTime() async {
    final response = await dio.post('$baseUrl/runtime-test');
    return RuntimeTest.fromJson(response.data!);
  }

  Future<Schedule> getPumpSchedule() async {
    final response = await dio.get<Map<String, dynamic>>('$baseUrl/schedule');
    return Schedule.fromJson(response.data!);
  }

  Future<Schedule> updatePumpSchedule(Schedule schedule) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/schedule',
      data: schedule.toJson(),
    );
    return Schedule.fromJson(response.data!);
  }
}
