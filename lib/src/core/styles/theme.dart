import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/core/styles/color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        canvasColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: AppColors.textGray,
        ),
        primaryColor: AppColors.primary,
      );
}
