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
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle lighttext() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle semiboldtext() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins-SemiBold');
  }
}
