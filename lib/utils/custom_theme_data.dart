import 'package:flutter/material.dart';
import 'package:diary_sysman/ui/styles.dart';

// Define colores para el tema claro
final lightThemeColors = {
  'background': const Color(0xffF8F5F4),
  'card': Colors.white,
  'primaryText': Colors.black,
  'secondaryText': Colors.grey[700]!,
};

// Define colores para el tema oscuro
final darkThemeColors = {
  'background': const Color(0xff131224),
  'card': const Color(0xff433A4B),
  'primaryText': Colors.white,
  'secondaryText': Colors.grey[400]!,
};

// Tema claro
final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Cambia esto según tu color principal
    brightness: Brightness.light,
    background: lightThemeColors['background']!,
    onBackground: lightThemeColors['primaryText']!,
    primary: lightThemeColors['primaryText']!,
    onPrimary: lightThemeColors['background']!,
    secondary: lightThemeColors['secondaryText']!,
    onSecondary: lightThemeColors['background']!,
  ),
  scaffoldBackgroundColor: lightThemeColors['background'],
  cardColor: lightThemeColors['card'],
  textTheme: TextTheme(
    // bodyText1: TextStyle(color: lightThemeColors['primaryText']),
    // bodyText2: TextStyle(color: lightThemeColors['secondaryText']),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightThemeColors['background'],
    foregroundColor: lightThemeColors['primaryText'],
  ),
);

// Tema oscuro
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Cambia esto según tu color principal
    brightness: Brightness.dark,
    background: darkThemeColors['background']!,
    onBackground: darkThemeColors['primaryText']!,
    primary: darkThemeColors['primaryText']!,
    onPrimary: darkThemeColors['background']!,
    secondary: darkThemeColors['secondaryText']!,
    onSecondary: darkThemeColors['background']!,
  ),
  scaffoldBackgroundColor: darkThemeColors['background'],
  cardColor: darkThemeColors['card'],
  textTheme: TextTheme(
    // bodyText1: TextStyle(color: darkThemeColors['primaryText']),
    // bodyText2: TextStyle(color: darkThemeColors['secondaryText']),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkThemeColors['background'],
    foregroundColor: darkThemeColors['primaryText'],
  ),
);
