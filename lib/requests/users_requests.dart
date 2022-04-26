import 'package:dio/dio.dart';
import 'package:flutter_app_starter/models/dataformat.dart';
import 'package:flutter_app_starter/requests/requests.dart';
import 'package:flutter_app_starter/requests/requests_group.dart';

class UserRequests extends RequestsGroup {
  static const String _routeGetUser = '/users/{id}';
  static const String _idPlaceholder = '{id}';

  UserRequests(Dio dio, ComputeRequest computeRequest) : super(dio, computeRequest);

  Future<User> getUsers({required String id}) async {
    var res = await computeRequest(dio.get(
        _routeGetUser.replaceAll(_idPlaceholder, id),
    ), "user");

    if (res is Error || res is Exception) {
      throw res;
    } else {
      return User.fromJson(res);
    }
  }
}