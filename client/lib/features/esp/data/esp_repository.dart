import 'package:client/core/network/api_client.dart';
import 'package:client/features/esp/domain/esp_status.dart';

class EspRepository {
  final ApiClient _api;

  EspRepository(this._api);

  Future<EspStatus> getStatus() {
    return _api.get('/status', mapper: (data) => EspStatus.fromJson(data));
  }
}
