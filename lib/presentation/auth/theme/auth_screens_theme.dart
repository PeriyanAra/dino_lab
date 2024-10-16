import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class AuthScreensTheme extends ThemeExtension<AuthScreensTheme> {
  const AuthScreensTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  })  : _colorTheme = colorTheme,
        _textTheme = textTheme;

  final DinoLabColorTheme _colorTheme;
  final DinoLabTextTheme _textTheme;

  TextStyle get titleTextStyle => _textTheme.displayLarge;

  TextStyle get subTitleTextStyle => _textTheme.bodyLarge;

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        _textTheme,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthScreensTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  AuthScreensTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return AuthScreensTheme(
        textTheme: textTheme ?? _textTheme,
        colorTheme: colorTheme ?? _colorTheme);
  }

  @override
  ThemeExtension<AuthScreensTheme> lerp(
    covariant ThemeExtension<AuthScreensTheme>? other,
    double t,
  ) {
    return this;
  }

  static AuthScreensTheme of(BuildContext context) {
    return Theme.of(context).extension<AuthScreensTheme>()!;
  }
}
