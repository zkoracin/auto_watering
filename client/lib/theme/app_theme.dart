
import 'package:client/theme/app_color_scheme.dart';
import 'package:client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,

    scaffoldBackgroundColor: AppColors.surface,

    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge: GoogleFonts.lato(color: AppColors.textPrimary),
      bodyMedium: GoogleFonts.lato(color: AppColors.textPrimary),
      bodySmall: GoogleFonts.lato(color: AppColors.textSecondary),
    ),
    
  );
}
