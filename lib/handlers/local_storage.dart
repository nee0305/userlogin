import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:userlogin/models/user_response.dart';

class SharedPref {
  final _sharedPref = SharedPreferences.getInstance();

  Future storeUserData(Map data) async {
    final pref = await _sharedPref;
    var encodedData = jsonEncode(data);
    await pref.setString('userData', encodedData);
  }

  dynamic getUserData() async {
    final pref = await _sharedPref;
    var data = pref.getString('userData');
    log('data -> $data');
    if (data != null) {
      return UserResponse.fromJson(jsonDecode(data));
    }
  }
}
