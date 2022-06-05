import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:userlogin/models/user_response.dart';

class ApiClient {
  final _dio = Dio();

  dynamic loginUser(String email, String password) async {
    //var response = await _dio.get('https://reqres.in/api/users?page=1');
    var response = await _dio.post('https://reqres.in/api/login', data: {
      'email': email,
      'password': password
    },);
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.data);
    } else {
      log('api err -> ${response.statusCode} -> ${response.statusMessage}');
      return null;
    }
  }
}
