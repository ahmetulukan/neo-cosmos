import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A0E21),
    scaffoldBackgroundColor: const Color(0xFF0A0E21),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A0E21),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00D4FF),
      secondary: Color(0xFF9C27B0),
      surface: Color(0xFF1D1E33),
      error: Color(0xFFCF6679),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.white54,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1D1E33),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF00D4FF),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00D4FF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1D1E33),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF00D4FF), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(color: Colors.white54),
      labelStyle: const TextStyle(color: Colors.white70),
    ),
  );

  // Resource colors
  static const Color titaniumColor = Color(0xFF4FC3F7);
  static const Color quantumFuelColor = Color(0xFFBA68C8);
  static const Color creditColor = Color(0xFFFFD54F);
  static const Color healthColor = Color(0xFF4CAF50);
  static const Color energyColor = Color(0xFF00D4FF);
  
  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Gradient backgrounds
  static LinearGradient spaceGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0A0E21),
      Color(0xFF1A1E33),
      Color(0xFF2A2E43),
    ],
  );
  
  static LinearGradient buttonGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00D4FF),
      Color(0xFF0099CC),
    ],
  );
  
  // Text styles
  static TextStyle resourceTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static TextStyle timerTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFF00D4FF),
    fontFamily: 'Monospace',
  );
  
  static TextStyle storyTextStyle = const TextStyle(
    fontSize: 16,
    height: 1.5,
    color: Colors.white70,
    fontFamily: 'Serif',
  );
}