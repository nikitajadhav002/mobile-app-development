import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white60),
  ),
);
