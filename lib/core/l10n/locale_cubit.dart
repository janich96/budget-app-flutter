import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _prefKey = 'app_locale';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(_loadLocale(_prefs));

  static Locale _loadLocale(SharedPreferences prefs) {
    final code = prefs.getString(_prefKey);
    if (code == 'en') return const Locale('en');
    return const Locale('ru');
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_prefKey, locale.languageCode);
    emit(locale);
  }
}
