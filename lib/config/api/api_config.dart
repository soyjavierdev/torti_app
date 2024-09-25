import 'package:dio/dio.dart';

class ApiConfig {
  static Dio dioNoAuth(String url) {
    return Dio(BaseOptions(baseUrl: url));
  }
}
