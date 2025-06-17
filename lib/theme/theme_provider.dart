import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pinkAccent,
    colorScheme: ColorScheme.light(
      primary: Colors.pinkAccent,
      onPrimary: Colors.white,
      secondary: Colors.pinkAccent.shade100,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black87,
      background: Colors.white,
      onBackground: Colors.black87,
      error: Colors.red,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pinkAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.pinkAccent,
        side: const BorderSide(color: Colors.pinkAccent),
      ),
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.pinkAccent,
    colorScheme: ColorScheme.dark(
      primary: Colors.pinkAccent,
      onPrimary: Colors.white,
      secondary: Colors.pinkAccent.shade100,
      onSecondary: Colors.white,
      surface: Colors.grey.shade800,
      onSurface: Colors.white70,
      background: Colors.grey.shade900,
      onBackground: Colors.white70,
      error: Colors.redAccent,
      onError: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    cardColor: Colors.grey.shade800,
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.5),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pinkAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.pinkAccent,
        side: const BorderSide(color: Colors.pinkAccent),
      ),
    ),
  );
} 