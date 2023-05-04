// Package imports:
import 'package:dio/dio.dart';

class HttpService {
  final _httpClient = Dio();

  Future<Response> getData({BaseOptions? options, required String path}) async {
    try {
      _httpClient.options;
      final response = await _httpClient.get(path);
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }
}
