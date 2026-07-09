import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom theme definitions and palette tokens for the R. Borger-Johnson Portfolio.
/// This file acts as the source-of-truth for style constants in Dart.
class PortfolioTheme {
  // Brand Colors
  static const Color creamBg = Color(0xFFFAF6EE);
  static const Color terracotta = Color(0xFFD36135);
  static const Color sageGreen = Color(0xFF7A8B7B);
  static const Color warmWood = Color(0xFF2F251E);
  static const Color sandSurface = Color(0xFFEAE3D2);
  static const Color sageGreenLight = Color(0xFFE8ECE8);
  static const Color terracottaLight = Color(0xFFFBF1EC);

  /// Builds the custom ThemeData matching the Warm & Earthy design spec.
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: creamBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: terracotta,
        primary: terracotta,
        secondary: sageGreen,
        surface: sandSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: warmWood,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.fraunces(
          textStyle: const TextStyle(
            color: warmWood,
            fontWeight: FontWeight.bold,
            fontSize: 54,
            height: 1.15,
          ),
        ),
        displayMedium: GoogleFonts.fraunces(
          textStyle: const TextStyle(
            color: warmWood,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        displaySmall: GoogleFonts.fraunces(
          textStyle: const TextStyle(
            color: warmWood,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        titleLarge: GoogleFonts.fraunces(
          textStyle: const TextStyle(
            color: warmWood,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          textStyle: const TextStyle(
            color: warmWood,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          textStyle: const TextStyle(
            color: warmWood,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
