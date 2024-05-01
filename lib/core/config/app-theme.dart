import 'package:flutter/material.dart';
class Appthemes {
  static ThemeData theme = ThemeData(
      primaryColor: const Color(0XFF282A28),
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.transparent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0XFF1A1A1A),
        selectedItemColor: Colors.yellow,
        selectedIconTheme: const IconThemeData(
          color: Colors.yellow,
          size: 38,
        ),
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(
          color: Color(0XFFC6C6C6),
          size: 48
        ),
        ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.white,
        ),
        bodySmall: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      )

  );
}

