import 'package:flutter/material.dart';

class AppTheme {
  // Primary Color - Teal
  static const Color primary = Color(0xFF00A0A0);
  
  // Secondary Color - Blue
  static const Color secondary = Color(0xFF2C80FF);
  
  // Accent Color - Purple
  static const Color accent = Color(0xFF6A5ACD);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);
  
  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  
  // Neutral Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primary,
    secondary: secondary,
    tertiary: accent,
    background: backgroundLight,
    surface: surfaceLight,
    onBackground: textPrimaryLight,
    onSurface: textPrimaryLight,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    brightness: Brightness.light,
    error: error,
    onError: Colors.white,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primary,
    secondary: secondary,
    tertiary: accent,
    background: backgroundDark,
    surface: surfaceDark,
    onBackground: textPrimaryDark,
    onSurface: textPrimaryDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    brightness: Brightness.dark,
    error: error,
    onError: Colors.white,
  );
  
  // Border Radius
  static final BorderRadius borderRadiusSmall = BorderRadius.circular(4.0);
  static final BorderRadius borderRadiusMedium = BorderRadius.circular(8.0);
  static final BorderRadius borderRadiusLarge = BorderRadius.circular(12.0);
  static final BorderRadius borderRadiusXLarge = BorderRadius.circular(16.0);
  
  // Shadows - Light Theme
  static List<BoxShadow> shadowSmallLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> shadowMediumLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> shadowLargeLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // Shadows - Dark Theme
  static List<BoxShadow> shadowSmallDark = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> shadowMediumDark = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> shadowLargeDark = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}