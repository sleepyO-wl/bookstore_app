import 'dart:convert';

import 'package:bookstore/provider/user_provider.dart';
import 'package:bookstore/screens/home_screen.dart';
import 'package:bookstore/utils/uri.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bookstore/models/user.dart';

class AuthService {
  void userSignUp(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          type: '',
          token: '');

      // final response =
      await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print('$response.statusCode');
    } catch (e) {
      rethrow;
    }
  }

  void userLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();

// ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setUser(response.body);

      await prefs.setString('token', json.decode(response.body)['token']);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
      // print('$response.statusCode');
    } catch (e) {
      rethrow;
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == '') {
        prefs.setString('token', '');
      }

      var tokenResponse = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
      );

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        final userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
