import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

const _halfT = 0.5;

@immutable
class DinoLabColorTheme extends ThemeExtension<DinoLabColorTheme> {
  const DinoLabColorTheme({
    required this.brightness,
    required this.primary,
    required this.secondary,
    required this.error,
    required this.warning,
    required this.success,
    required this.backgroundPrimary,
  });

  final Brightness brightness;
  final DinoLabColor primary;
  final DinoLabColor secondary;
  final DinoLabColor error;
  final DinoLabColor success;
  final DinoLabColor warning;
  final DinoLabColor backgroundPrimary;

  @override
  int get hashCode => Object.hash(
        primary,
        secondary,
        error,
        success,
        warning,
        backgroundPrimary,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinoLabColorTheme &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          secondary == other.secondary &&
          error == other.error &&
          success == other.success &&
          warning == other.warning &&
          backgroundPrimary == other.backgroundPrimary;

  @override
  DinoLabColorTheme copyWith({
    DinoLabColor? primary,
    DinoLabColor? secondary,
  }) {
    return DinoLabColorTheme(
      brightness: brightness,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      error: error,
      success: success,
      warning: warning,
      backgroundPrimary: backgroundPrimary,
    );
  }

  @override
  ThemeExtension<DinoLabColorTheme> lerp(
    covariant ThemeExtension<DinoLabColorTheme>? other,
    double t,
  ) {
    if (other is! DinoLabColorTheme) {
      return this;
    }

    return DinoLabColorTheme(
      brightness: t < _halfT ? brightness : other.brightness,
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      error: error.lerp(other.error, t),
      success: success.lerp(other.success, t),
      warning: warning.lerp(other.warning, t),
      backgroundPrimary: backgroundPrimary.lerp(other.backgroundPrimary, t),
    );
  }

  static DinoLabColorTheme of(BuildContext context) {
    return Theme.of(context).extension<DinoLabColorTheme>()!;
  }
}
