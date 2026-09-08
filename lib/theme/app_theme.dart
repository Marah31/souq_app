import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color peach = Color(0xFFFFCCBC); 
  static const Color apricot = Color(0xFFFFAB91);
  static const Color coral = Color(0xFFFF8A65); 
  static const Color burntOrange = Color(0xFFD84315);
  static const Color rust = Color(0xFFBF360C); 

  //static const Color background = Color(0xFFFFFAF8);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color imageBackdrop = Color(0xFFFFF1EB);
}

class AppTheme {
  AppTheme._();

  static const double maxContentWidth = 900.0;

  static double pagePadding(double screenWidth) {
    if (screenWidth >= 1000) return 40;
    if (screenWidth >= 700) return 28;
    return 16;
  }

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.rust,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.rust,
      onPrimary: Colors.white,
      secondary: AppColors.coral,
      onSecondary: Colors.white,
      tertiary: AppColors.burntOrange,
      surface: AppColors.surface,
      onSurface: const Color(0xFF2B1D17),
      surfaceContainerHighest: AppColors.imageBackdrop,
      outline: AppColors.apricot.withValues(alpha: 0.6),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      //scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        //backgroundColor: AppColors.background,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        titleMedium: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.primary,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          height: 1.25,
          color: const Color(0xFF3A2A22),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.imageBackdrop,
        hintStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.imageBackdrop,
        selectedColor: AppColors.rust,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF3A2A22),
        ),
        secondaryLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
    );
  }
}