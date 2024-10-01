import 'package:flutter/material.dart';
import 'dart:convert';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  static Map<String, Map<String, String>> translations = {
    'en': {
      'home': 'Home',
      'welcome': 'Welcome!',
      'user': 'User',
      'seller': 'Seller',
      'login': 'Login',
      'register': 'Register',
      // Add other English translations
    },
    'vi': {
      'home': 'Trang chủ',
      'welcome': 'Chào mừng!',
      'user': 'Người dùng',
      'seller': 'Người bán',
      'login': 'Đăng nhập',
      'register': 'Đăng ký',
      // Add other Vietnamese translations
    },
    // Add other language translations as needed
  };

static String translateFullName(BuildContext context, String fullNameKey) {
    final String translatedName = translations[Localizations.localeOf(context).languageCode]![fullNameKey.toLowerCase()] ?? fullNameKey;
    return utf8.decode(translatedName.runes.toList());
  }
  static String of(BuildContext context, String key) {
    return translations[Localizations.localeOf(context).languageCode]![key] ?? key;
  }
  
}
