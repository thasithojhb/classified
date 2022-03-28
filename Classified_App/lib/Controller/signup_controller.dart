import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/services/services.dart';

class Signup {

  Future<bool> validate(String name, String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> res = jsonDecode(await Services().signup(name , username, email, password));

// set value
    if (!res['valid']) {
      return false;
    }
    prefs.setString('token', res['token']);
    return true;
  }
}