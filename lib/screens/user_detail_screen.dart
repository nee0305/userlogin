// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:userlogin/models/user_response.dart';
import 'package:userlogin/handlers/local_storage.dart';

class DetailScreen extends StatelessWidget {

  final data;

  DetailScreen({required this.data});

  var loginResp = UserResponse();
  var preference = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //TODO: back press event
            Navigator.pop(context);
          },
        ),
        title: Text('User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User Token: "),
            _customText(data ?? 'token')
          ],
        ),
      ),
    );
  }

  Widget _customText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
