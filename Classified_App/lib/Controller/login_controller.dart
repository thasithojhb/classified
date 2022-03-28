import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/services/services.dart';

class Login {

  Future<bool> validate(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> res = jsonDecode(await Services().login(username, password));

// set value
    if (!res['valid']) {
      return false;
    }
    prefs.setString('token', res['token']);
    return true;
  }
  Future<int> getProducts(BuildContext context) {
    return Services().fetchProducts(context);
  }
}