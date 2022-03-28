import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled/models/quote.dart';
import 'package:http/http.dart' as http;

import 'package:untitled/HTTPservice.dart';

class Product extends ChangeNotifier {

  // Future<dynamic> getData () =>  HTTPService().fetchQuotes();
  final List<Map> _quoteList = [];

  List<Map> get getQuoteList => this._quoteList;
  // set setData(BuildContext context) {
  //   Future<dynamic> response = this.getData();
  //   notifyListeners();
  //   for ( Map quote in jsonDecode(response.toString())) {
  //     this.addQuote(quote);
  //   }
  //   print('${this._quoteList} joj');
  // }
  void addQuote(Map quote) {
    this._quoteList.add(quote);
    notifyListeners();
  }

  void addAllQuote(List<Map> quote) {
    this._quoteList.clear();
    this._quoteList.addAll(quote);
  }
}