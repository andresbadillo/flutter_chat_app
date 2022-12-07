import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_real_time_app/models/usuario.dart';
import 'package:chat_real_time_app/models/login_response.dart';
import '../global/environment.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;

  Future login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
    }
  }
}
