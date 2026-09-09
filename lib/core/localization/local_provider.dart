import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _localeKey = 'user_app_locale';

class LocaleNotifier extends Notifier<Locale> {
  SharedPreferences? _prefs;

  @override
  Locale build() {
    _initPrefs();
    return const Locale('en'); 
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = _prefs?.getString(_localeKey);

    if (savedLanguageCode != null && state.languageCode != savedLanguageCode) {
      state = Locale(savedLanguageCode);
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (state == newLocale) return;
    
    state = newLocale;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString(_localeKey, newLocale.languageCode);
  }

  Future<void> toggleLanguage() async {
    final newLocale = state.languageCode == 'en' 
        ? const Locale('ar') 
        : const Locale('en');
    await setLocale(newLocale);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);