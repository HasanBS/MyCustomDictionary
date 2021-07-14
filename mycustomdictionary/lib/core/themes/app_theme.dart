import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static Color lightBackgroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xFF6F35A5);
  static Color lightPrimaryLightColor = Color(0xFFF1E6FF); //
  static Color lightPrimaryUserColor = Color(0xFFF4F5DB);
  static Color lightPrimaryFabButtonColor = Color(0xFFFF4D4D);
  static Color lightPrimaryWordAddButtonColor = Color(0xFF77ACF1);

//F4F5DB
  //static Color lightAccentColor = Colors.blueGrey.shade200;

  static Color darkBackgroundColor = const Color(0xFF1A2127);
  static Color darkPrimaryColor = Color(0xFF6F35A5);
  static Color darkPrimaryLightColor = Color(0xFFF1E6FF);

  //static Color darkAccentColor = Colors.blueGrey.shade600;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackgroundColor,
    //accentColor: lightAccentColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackgroundColor,
    //accentColor: darkAccentColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
