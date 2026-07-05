import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const double _borderRadius = 20.0;

  // Цветовые константы для кастомизации
  static const Color primaryLight = Color(0xFF2D5AF6);
  static const Color primaryDark = Color(0xFF6B8AFF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryLight,
      brightness: Brightness.light,
      surface: const Color(0xFFF1F5F9), // Слегка сероватый фон для контраста с белыми карточками
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E293B),
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      color: Colors.white,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        enabledMouseCursor: SystemMouseCursors.click,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: primaryLight, width: 2),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: primaryLight.withOpacity(0.1),
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selectedLabelTextStyle: GoogleFonts.inter(
        color: primaryLight,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        color: const Color(0xFF64748B),
        fontSize: 13,
      ),
      selectedIconTheme: const IconThemeData(color: primaryLight),
      unselectedIconTheme: const IconThemeData(color: Color(0xFF64748B)),
    ),
    listTileTheme: ListTileThemeData(
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      brightness: Brightness.dark,
      surface: const Color(0xFF0F172A), // Глубокий темно-синий/черный
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      color: const Color(0xFF1E293B), // Светлее чем surface
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        enabledMouseCursor: SystemMouseCursors.click,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: primaryDark, width: 2),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: primaryDark.withOpacity(0.2),
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selectedLabelTextStyle: GoogleFonts.inter(
        color: primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        color: const Color(0xFF94A3B8),
        fontSize: 13,
      ),
      selectedIconTheme: const IconThemeData(color: primaryDark),
      unselectedIconTheme: const IconThemeData(color: Color(0xFF94A3B8)),
    ),
    listTileTheme: ListTileThemeData(
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: const Color(0xFF1E293B),
    ),
  );
}
