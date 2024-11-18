// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String apiUrl = "http://127.0.0.1:5000/auth";
  final storage = FlutterSecureStorage();

  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );
    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)["token"];
      await storage.write(key: "jwt_token", value: token);
      return token;
    }
    return null;
  }

  Future<String?> signup(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/signup'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );
    if (response.statusCode == 201) {
      String token = jsonDecode(response.body)["token"];
      await storage.write(key: "jwt_token", value: token);
      return token;
    }
    return null;
  }

  Future<void> logout() async {
    await storage.delete(key: "jwt_token");
  }

  Future<bool> isAuthenticated() async {
    String? token = await storage.read(key: "jwt_token");
    return token != null;
  }
}
