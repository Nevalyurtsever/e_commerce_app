import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  TextThemeExtension(
      {required this.titleStyle,
      required this.subtitleStyle,
      required this.boldSubtitleStyle,
      required this.bodyMedium,
      required this.contentMedium});

  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle boldSubtitleStyle;
  final TextStyle bodyMedium;
  final TextStyle contentMedium;

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? boldSubtitleStyle,
    TextStyle? bodyMedium,
    TextStyle? contentMedium,
  }) {
    return TextThemeExtension(
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      boldSubtitleStyle: boldSubtitleStyle ?? this.boldSubtitleStyle,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      contentMedium: contentMedium ?? this.contentMedium,
    );
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(
    covariant ThemeExtension<TextThemeExtension>? other,
    double t,
  ) {
    if (other is! TextThemeExtension) {
      return this;
    }

    return TextThemeExtension(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      boldSubtitleStyle:
          TextStyle.lerp(boldSubtitleStyle, other.boldSubtitleStyle, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      contentMedium: TextStyle.lerp(contentMedium, other.contentMedium, t)!,
    );
  }
}
