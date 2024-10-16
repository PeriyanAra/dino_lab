import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class PrimaryButtonTheme extends ThemeExtension<PrimaryButtonTheme> {
  const PrimaryButtonTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  })  : _colorTheme = colorTheme,
        _textTheme = textTheme;

  final DinoLabColorTheme _colorTheme;
  final DinoLabTextTheme _textTheme;

  ButtonStyle get buttonStyle => ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              7.0,
            ),
          ),
        ),
        backgroundColor: _colorTheme.primary,
      );

  TextStyle get textStyle => _textTheme.headlineMedium.copyWith(
        color: DinoLabColorsPalette.white100,
        fontWeight: FontWeight.bold,
      );

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        _textTheme,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimaryButtonTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  PrimaryButtonTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return PrimaryButtonTheme(
        textTheme: textTheme ?? _textTheme,
        colorTheme: colorTheme ?? _colorTheme);
  }

  @override
  ThemeExtension<PrimaryButtonTheme> lerp(
    covariant ThemeExtension<PrimaryButtonTheme>? other,
    double t,
  ) {
    return this;
  }

  static PrimaryButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<PrimaryButtonTheme>()!;
  }
}
