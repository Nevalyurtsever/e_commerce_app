import 'package:flutter/material.dart';

import 'app_color_extensions.dart';
import 'app_palette.dart';
import 'app_typography.dart';
import 'dark_theme.dart';
import 'light_theme.dart';
import 'text_theme_extensions.dart';

class AppTheme {
  static final light = lightTheme.copyWith(
    extensions: [_lightAppColors, _lightTextTheme],
  );

  static final _lightAppColors = AppColorsExtension(
    primary: AppPalette.primary,
    onPrimary: Colors.white,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffb00020),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    cardColor: AppPalette.lightCardColor,
    svgIconColor: const Color(0xff2d3139),
    danger: AppPalette.danger,
    productCardBorderColor: Colors.grey.shade100,
    borderColor: const Color(0xFFE2E2E2),
  );

  static final dark = darkTheme.copyWith(
    extensions: [_darkAppColors, _darkTextTheme],
  );

  static final _darkAppColors = AppColorsExtension(
    primary: AppPalette.primary,
    onPrimary: Colors.black,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffcf6679),
    onError: Colors.black,
    background: const Color(0xff121212),
    onBackground: Colors.white,
    surface: const Color(0xff121212),
    onSurface: Colors.white,
    cardColor: AppPalette.darkCardColor,
    svgIconColor: Colors.white,
    danger: AppPalette.danger,
    productCardBorderColor: Colors.grey.shade900,
    borderColor: const Color(0xFFF0F0F0),
  );

  static final _lightTextTheme = TextThemeExtension(
      titleStyle: AppTypography.lightTitleStyle,
      subtitleStyle:
          const TextStyle(height: 0.5, fontSize: 16, color: Colors.grey),
      boldSubtitleStyle: AppTypography.boldSubtitleStyle,
      bodyMedium: AppTypography.bodyMedium,
      contentMedium: AppTypography.contentMedium);

  static final _darkTextTheme = TextThemeExtension(
      titleStyle: AppTypography.darkTitleStyle,
      subtitleStyle:
          const TextStyle(height: 0.5, fontSize: 16, color: Colors.grey),
      boldSubtitleStyle: AppTypography.boldSubtitleStyle,
      bodyMedium: AppTypography.bodyMedium,
      contentMedium: AppTypography.contentMediumDark);
}
