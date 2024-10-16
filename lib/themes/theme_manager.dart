import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
static final mySystemTheme= SystemUiOverlayStyle.light
 .copyWith(systemNavigationBarColor: const Color.fromARGB(255, 13, 18, 87));
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      )
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(),
      filled: true,
      fillColor: null,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue
        ),
        borderRadius: BorderRadius.circular(20)
      ),
    ),
    fontFamily: "",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey
      ),
      headlineSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w200,
        color: null,
      )
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.white,
      tertiary: null
    )
    
  );


  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      )
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(),
      filled: true,
      fillColor: null,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue
        ),
        borderRadius: BorderRadius.circular(20)
      ),
    ),
    fontFamily: "",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey
      ),
      headlineSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w200,
        color: null,
      )
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.white,
      tertiary: null
    )
    
  );

  
}