import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_starter/requests/requests_errors.dart';
import 'package:flutter_app_starter/requests/users_requests.dart';

typedef ComputeRequest = Future<dynamic> Function(Future<Response> request, [String? dataMapping]);

class Requests {
  static late Requests _instance;

  static String? _authToken;
  static Requests init({required String serverAddress}) {
    _instance = Requests._(serverAddress);
    return _instance;
  }
  static set authToken(String? value) => _authToken = value;

  //static String get deviceName => "${_deviceInfo.utsname.machine}: ${_deviceInfo.systemName} ${_deviceInfo.systemVersion}";

  static Requests get instance => _instance;

  late Dio _dio;
  late UserRequests _userRequests;

  Requests._(String serverAddress) {
    BaseOptions options = BaseOptions(
      baseUrl: serverAddress,
      connectTimeout: 300 * 1000,
      sendTimeout: 300 * 1000,
      receiveTimeout: 300 * 1000,
      headers: {},
      validateStatus: (status) {
        return status! < 500;
      },
    );
    _dio = Dio(options);

    _userRequests = UserRequests(_dio, _computeRequest);
  }

  UserRequests get userRequests => _userRequests;

  Future<dynamic> _computeRequest(Future<Response> request, [String? dataMapping]) async {
    Response response;
    try {
      response = await request;

      print('${response.requestOptions.method} ${response.requestOptions.path} result = ${response.data}');
      if (response.statusCode != HttpStatus.internalServerError) {
        if (response.data["error"])
          // on passe l'object Response
          return ResponseException(RequestsErrors.find(response.data["error_code"]));
        else return dataMapping == null ? response.data : response.data[dataMapping];
      } else {
        print('bad return : ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('da error is $e');
      return e;
    }
  }

  Future<File> downloadRandom(String url, String path) async {
    try {
      await Dio().download(url, path);
      return File(path);
    } catch (e) {
      print('$e');
      throw e;
    }
  }
}