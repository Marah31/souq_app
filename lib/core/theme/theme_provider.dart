import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'user_theme_mode';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  SharedPreferences? _prefs;

  @override
  ThemeMode build() {
    _initPrefs();
    return ThemeMode.system; 
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final savedMode = _prefs?.getString(_themeKey);

    if (savedMode == 'light' && state != ThemeMode.light) {
      state = ThemeMode.light;
    } else if (savedMode == 'dark' && state != ThemeMode.dark) {
      state = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    final nextMode = switch (state) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };

    state = nextMode;

    _prefs ??= await SharedPreferences.getInstance();
    if (nextMode == ThemeMode.system) {
      await _prefs?.remove(_themeKey);
    } else {
      await _prefs?.setString(_themeKey, nextMode.name);
    }
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);