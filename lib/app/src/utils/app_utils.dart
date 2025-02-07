

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}