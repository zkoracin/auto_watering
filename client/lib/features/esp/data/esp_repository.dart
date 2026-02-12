import 'package:client/core/network/api_client.dart';
import 'package:client/features/esp/domain/esp_status.dart';
import 'package:client/features/esp/domain/esp_time.dart';

class EspRepository {
  final ApiClient _api;
  static const String _basePath = '/device';

  EspRepository(this._api);

  Future<EspStatus> getStatus() {
    return _api.get(
      '$_basePath/status',
      mapper: (data) => EspStatus.fromJson(data),
    );
  }

  Future<EspTime> getTime() {
    return _api.get(
      '$_basePath/time',
      mapper: (data) => EspTime.fromJson(data),
    );
  }

  //@TODO First fetch the time from the esp then set it up if needed
  Future<EspTime> setTime(EspTime time) {
    return _api.post(
      '$_basePath/time',
      data: time.toJson(),
      mapper: (data) => EspTime.fromJson(data),
    );
  }
}
