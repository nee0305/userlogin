// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:userlogin/models/user_response.dart';
import 'package:userlogin/handlers/api_client.dart';
import 'package:userlogin/handlers/local_storage.dart';
import 'package:userlogin/screens/user_detail_screen.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}


class _UserLoginState extends State<UserLogin> {
  var loginResp = UserResponse();
  var preference = SharedPref();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userToken = loginResp.token;
    return Material(
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'APIIntegrationDemo',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'User Login',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(emailController.text);
                    print(passwordController.text);
                    _parseData();
                  },
                )
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Show User Details'),
                  onPressed: () {
                    _saveDataToLocal();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(data: userToken),
                      ),
                    );
                  },
                )
            ),
          ],
        ));
  }

  _saveDataToLocal() async {
    await preference.storeUserData(loginResp.toJson());
    loginResp = UserResponse();
    setState(() {});
  }

  Future<void> _parseData() async {
    var apiClient = ApiClient();
    var data = await apiClient.loginUser(emailController.text, passwordController.text);
    if (data != null) {
      loginResp = data;
    }
    log('data -> ${loginResp.toJson()}');
    setState(() {});
  }
}

//login credentials
// {
// "email": "eve.holt@reqres.in",
// "password": "cityslicka"
// }
// {
// "token": "QpwL5tke4Pnpja7X4"
// }
