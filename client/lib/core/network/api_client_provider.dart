import 'package:client/core/network/api_client.dart';
import 'package:client/core/network/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});
