import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/services/services.dart';

import '../models/product.dart';
import 'controller.dart';

class Login {

  Future<bool> validate(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> res = jsonDecode(await Services().login(username, password));

// set value
    if (!res['valid']) {
      return false;
    }
    prefs.setString('token', res['token']);
    print(prefs.getString('login'));
    return true;
  }
  Future<int> getProducts(BuildContext context) {
    return Services().fetchProducts(context);
  }
}