import 'package:dio/dio.dart';
import 'package:flutter_app_starter/requests/requests.dart';

abstract class RequestsGroup {
  final Dio? _dio;
  final ComputeRequest _computeRequest;

  RequestsGroup(this._dio, this._computeRequest);
}