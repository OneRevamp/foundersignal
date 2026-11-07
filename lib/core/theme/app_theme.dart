import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const ink = Color(0xFF252923);
    const paper = Color(0xFFF7F6F1);
    const muted = Color(0xFF777B72);
    const accent = Color(0xFF647A68);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.light,
      surface: paper,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: paper,
      fontFamily: 'sans-serif',
      textTheme: ThemeData.light().textTheme.apply(
            bodyColor: ink,
            displayColor: ink,
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paper,
        indicatorColor: accent.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      dividerColor: muted.withValues(alpha: 0.18),
    );
  }
}
