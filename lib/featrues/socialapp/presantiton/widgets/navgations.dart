import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void navigtonto(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
void navigtonandfinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false);
}