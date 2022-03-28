import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/HTTPservice.dart';
import 'package:untitled/models/quote.dart';
import 'package:untitled/models/product.dart';

import '../services/services.dart';



class Controller {

  List<Map> getQuoteList (BuildContext context) => Provider.of<Product>(context, listen: false).getQuoteList;

  // Future<int> getData () =>  Services().fetchProducts();
  void update(BuildContext context, futureQuotes) async {
    List<Map> fetchedQuotes = await futureQuotes;
    Provider.of<Product>(context, listen: false).addAllQuote(fetchedQuotes);
  }
  // void postData (BuildContext context, Map quote) => HTTPService().postQuotes(context, quote);

  }