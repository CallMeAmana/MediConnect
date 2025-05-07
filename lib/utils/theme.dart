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
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFE0E0E0);
  
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primary,
    secondary: secondary,
    tertiary: accent,
    background: background,
    surface: surface,
    onBackground: textPrimary,
    onSurface: textPrimary,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    brightness: Brightness.light,
    error: error,
    onError: Colors.white,
  );
  
  // Spacing System (based on 8px grid)
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  
  // Border Radius
  static final BorderRadius borderRadiusSmall = BorderRadius.circular(4.0);
  static final BorderRadius borderRadiusMedium = BorderRadius.circular(8.0);
  static final BorderRadius borderRadiusLarge = BorderRadius.circular(12.0);
  static final BorderRadius borderRadiusXLarge = BorderRadius.circular(16.0);
  
  // Shadows
  static List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}