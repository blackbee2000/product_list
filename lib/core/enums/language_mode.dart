import 'package:flutter/material.dart';

enum LanguageMode {
  vietnamese(Locale('vi', 'VN'), 'VIE');

  const LanguageMode(
    this.locale,
    this.shortName,
  );
  final Locale locale;
  final String shortName;

  static LanguageMode mapping(String? shortName) {
    if (shortName == null) {
      return LanguageMode.vietnamese;
    }

    return LanguageMode.vietnamese;
  }
}
