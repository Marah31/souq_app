import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color peach = Color(0xFFFFCCBC);
  static const Color apricot = Color(0xFFFFAB91);
  static const Color coral = Color(0xFFFF6F3C); 
  static const Color burntOrange = Color(0xFFE8590C);
  static const Color rust = Color(0xFFC2410C);

  static const Color zestLime = Color(0xFFB4E600);
  static const Color electricTeal = Color(0xFF00C2A8);

  static const Color backgroundLight = Color(0xFFFFF9F6); 
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFFFF1EB);
  static const Color textLight = Color(0xFF241712);
  static const Color textBodyLight = Color(0xFF4A362C);
  static const Color textMutedLight = Color(0xFF8A7368);

  static const Color backgroundDark = Color(0xFF15171E);
  static const Color surfaceDark = Color(0xFF1E212B);
  static const Color surfaceContainerDark = Color(0xFF272B37);
  static const Color textDark = Color(0xFFF6F1EC);
  static const Color textBodyDark = Color(0xFFD8D1C8);
  static const Color textMutedDark = Color(0xFF9B958E);
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
      primary: AppColors.coral,
      onPrimary: Colors.white,
      primaryContainer: AppColors.peach,
      onPrimaryContainer: AppColors.rust,
      secondary: AppColors.electricTeal,
      onSecondary: Colors.white,
      tertiary: AppColors.zestLime,
      onTertiary: AppColors.textLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textLight,
      surfaceContainerHighest: AppColors.surfaceContainerLight,
      surfaceContainer: AppColors.surfaceContainerLight,
      outline: AppColors.apricot.withValues(alpha: 0.6),
      error: const Color(0xFFD32F2F),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      canvasColor: AppColors.backgroundLight,
      fontFamily: 'Roboto',
    );

    final textTheme = base.textTheme
        .apply(
          bodyColor: AppColors.textBodyLight,
          displayColor: AppColors.textLight,
        )
        .copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textLight,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(
            height: 1.25,
            color: AppColors.textBodyLight,
          ),
          bodySmall: base.textTheme.bodySmall?.copyWith(
            color: AppColors.textMutedLight,
          ),
          labelLarge: base.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: textTheme.titleLarge,
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      primaryIconTheme: IconThemeData(color: colorScheme.primary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLight,
        hintStyle: TextStyle(color: AppColors.textMutedLight),
        labelStyle: TextStyle(color: AppColors.textBodyLight),
        prefixIconColor: colorScheme.primary,
        suffixIconColor: AppColors.textMutedLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surfaceContainerLight,
        selectedColor: colorScheme.primary,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textBodyLight,
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
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.tertiary,
        foregroundColor: AppColors.textLight,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: AppColors.textMutedLight,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.peach,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.primary : AppColors.textMutedLight,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? colorScheme.primary : AppColors.textMutedLight,
          );
        }),
      ),
      dividerTheme: DividerThemeData(color: AppColors.apricot.withValues(alpha: 0.3)),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? colorScheme.primary : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary.withValues(alpha: 0.5)
              : null,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.coral,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.coral,
      onPrimary: Colors.white,
      primaryContainer: AppColors.rust,
      onPrimaryContainer: AppColors.peach,
      secondary: AppColors.electricTeal,
      onSecondary: Colors.black,
      tertiary: AppColors.zestLime,
      onTertiary: Colors.black,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textDark,
      surfaceContainerHighest: AppColors.surfaceContainerDark,
      surfaceContainer: AppColors.surfaceContainerDark,
      outline: AppColors.burntOrange.withValues(alpha: 0.6),
      error: const Color(0xFFEF5350),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      canvasColor: AppColors.backgroundDark,
      fontFamily: 'Roboto',
    );

    final textTheme = base.textTheme
        .apply(
          bodyColor: AppColors.textBodyDark,
          displayColor: AppColors.textDark,
        )
        .copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(
            height: 1.25,
            color: AppColors.textBodyDark,
          ),
          bodySmall: base.textTheme.bodySmall?.copyWith(
            color: AppColors.textMutedDark,
          ),
          labelLarge: base.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: textTheme.titleLarge,
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      primaryIconTheme: IconThemeData(color: colorScheme.primary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerDark,
        hintStyle: TextStyle(color: AppColors.textMutedDark),
        labelStyle: TextStyle(color: AppColors.textBodyDark),
        prefixIconColor: colorScheme.primary,
        suffixIconColor: AppColors.textMutedDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surfaceContainerDark,
        selectedColor: colorScheme.primary,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
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
        color: AppColors.surfaceDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.tertiary,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: AppColors.textMutedDark,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.rust,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.primary : AppColors.textMutedDark,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? colorScheme.primary : AppColors.textMutedDark,
          );
        }),
      ),
      dividerTheme: DividerThemeData(color: AppColors.burntOrange.withValues(alpha: 0.3)),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? colorScheme.primary : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary.withValues(alpha: 0.5)
              : null,
        ),
      ),
    );
  }
}