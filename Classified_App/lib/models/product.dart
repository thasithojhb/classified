

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class Product extends ChangeNotifier {

  final List<Map> _productWantedList = [];
  final List<Map> _productForSaleList = [];

  List<Map> get getProductForSaleList => _productForSaleList;
  List<Map> get getProductWantedList => _productWantedList;

  void addProductForSale(Map quote) {
    _productForSaleList.add(quote);
    notifyListeners();
  }

  void addProductsForSale(List<Map> quote) {
    _productForSaleList.addAll(quote);
    notifyListeners();
  }
}