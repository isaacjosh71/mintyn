import 'dart:convert';

import 'package:flutter/services.dart';

import 'model.dart';

class UserRepository {
  Future<List<User>> fetchUser() async {
    final jsonString = await rootBundle.loadString(Config.baseUrl);
    final List<dynamic> data = json.decode(jsonString);
    return data.map((json) => User.fromJson(json)).toList();
  }
}


class Config {
  static const baseUrl = 'assets/json/json.json';
}