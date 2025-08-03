import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get custom => ThemeData(
    primaryColor: Colors.redAccent[700],
    scaffoldBackgroundColor: Colors.redAccent[700],
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 213, 0, 0),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.yellow),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodySmall: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.blueGrey),
      prefixIconColor: Colors.red,
      suffixIconColor: Colors.red,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Colors.cyan, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
    ),
  iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}