
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class Services {


  Future<String> login(String email, String password) async {
    Map body = {
      'Email': email, 'Password': password
    };
    print(body);
    final response = await http.post(
      Uri.parse('https://192.168.167.191:5001/api/Login'),
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    return response.body.toString();
    // if (response.statusCode == 201) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON
    //   // Provider.of<QuoteList>(context, listen: false).not();
    //
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  Future<String> signup(String name, username, String email, String password) async {
    Map body = {
      'Name': name, 'UserName': username, 'Email': email, 'Password': password
    };
    print(body);
    final response = await http.post(
      Uri.parse('https://192.168.167.191:5001/api/Signup'),
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    return response.body.toString();
    // if (response.statusCode == 201) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON
    //   // Provider.of<QuoteList>(context, listen: false).not();
    //
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  Future<int> fetchProducts(BuildContext context) async {
    final response = await http.get(Uri.parse('https://192.168.167.191:5001/api/Product'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // Provider.of<QuoteList>(context, listen: false).addQuote(jsonDecode(response.body));
      // Provider.of<QuoteList>(context, listen: false).not();
      Iterable decoded = json.decode(response.body);

      Provider.of<Product>(context, listen: false).addAllQuote(List<Map>.from(decoded.map((i) => i)));

      return response.statusCode;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<int> postForm(Map product, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('https://192.168.167.191:5001/api/Product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic ' + token!
      },
      body: jsonEncode(product),
    );
      print(response.body);
      Map decoded = json.decode(response.body);
      Provider.of<Product>(context, listen: false).addQuote(decoded);
      return response.statusCode;

  }
}