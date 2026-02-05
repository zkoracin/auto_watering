import 'package:client/features/pump/domain/runtime_test.dart';
import 'package:client/features/pump/domain/schedule.dart';
import 'package:client/features/pump/domain/pump_status.dart';
import 'package:client/features/pump/domain/runtime.dart';
import 'package:client/core/network/api_client.dart';

class PumpRepository {
  final ApiClient _api;
  static const String _basePath = '/pump';

  PumpRepository(this._api);

  Future<PumpStatus> getStatus() {
    return _api.get(_basePath, mapper: (data) => PumpStatus.fromJson(data));
  }

  Future<PumpStatus> toggle() {
    return _api.post(
      '$_basePath/toggle',
      mapper: (data) => PumpStatus.fromJson(data),
    );
  }

  Future<Runtime> getRuntime() {
    return _api.get(
      '$_basePath/runtime',
      mapper: (data) => Runtime.fromJson(data),
    );
  }

  Future<Runtime> updateRuntime(int seconds) {
    return _api.put(
      '$_basePath/runtime',
      data: {'seconds': seconds},
      mapper: (data) => Runtime.fromJson(data),
    );
  }

  Future<RuntimeTest> testRuntime() {
    return _api.post(
      '$_basePath/runtime-test',
      mapper: (data) => RuntimeTest.fromJson(data),
    );
  }

  Future<Schedule> getSchedule() {
    return _api.get(
      '$_basePath/schedule',
      mapper: (data) => Schedule.fromJson(data),
    );
  }

  Future<Schedule> updateSchedule(Schedule schedule) {
    return _api.put(
      '$_basePath/schedule',
      data: schedule.toJson(),
      mapper: (data) => Schedule.fromJson(data),
    );
  }
}
