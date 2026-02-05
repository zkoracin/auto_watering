import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;

  ApiClient(this._dio) : _baseUrl = dotenv.env['BASE_URL']!;

  Future<T> get<T>(String path, {T Function(dynamic data)? mapper}) async {
    final response = await _dio.get('$_baseUrl$path');
    return mapper != null ? mapper(response.data) : response.data as T;
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic data)? mapper,
  }) async {
    final response = await _dio.post('$_baseUrl$path', data: data);
    return mapper != null ? mapper(response.data) : response.data as T;
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic data)? mapper,
  }) async {
    final response = await _dio.put('$_baseUrl$path', data: data);
    return mapper != null ? mapper(response.data) : response.data as T;
  }
}
