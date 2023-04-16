import 'package:flutter/material.dart';

Widget reusableSolidButton(String text) {
  return Container(
    height: 40,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )),
    decoration: BoxDecoration(
      color: Color(0xFF304803),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

