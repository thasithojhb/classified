import 'package:flutter/material.dart';
import 'package:untitled/services/services.dart';

class PostFormData {
  Future<int> submit (Map product, BuildContext context) {
    return Services().postForm(product, context);
  }
}