import 'package:client/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppColorScheme {
  static final ColorScheme light = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,

    primary: AppColors.primary,
    secondary: AppColors.primaryLight,
    surface: AppColors.surface,
    error: AppColors.error,

    onPrimary: Colors.white,
    onSecondary: AppColors.textPrimary,
    onSurface: AppColors.textPrimary,
    onError: Colors.white,
  );
}
