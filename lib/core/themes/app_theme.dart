import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData themeData = ThemeData(
    useMaterial3: false,
    fontFamily: GoogleFonts.openSans().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.purple,
    brightness: Brightness.light,
  );
}
