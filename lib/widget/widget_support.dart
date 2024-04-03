import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldtext() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle headlinetext() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lighttext() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins');
  }

  static TextStyle semiboldtext() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
}
