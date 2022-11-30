import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget castomButton({
  required String text,
  double width = 120,
  double height = 35,
  Color? color,
  required Function onPressed,
  double raduis = 20,
  double padding = 0,
  bool isUpaercase = false,
}) {
  return Container(
    padding:  EdgeInsets.all(padding),
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(raduis)),
    child: MaterialButton(
      
      onPressed: () {
        onPressed();
      },
      child: Text(
        isUpaercase ? text.toUpperCase() : text,

        
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          
          
        ),
      ),
    ),
  );
}
