import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class SecondaryButtonTheme extends ThemeExtension<SecondaryButtonTheme> {
  const SecondaryButtonTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  }): _colorTheme = colorTheme,
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
        shadowColor: WidgetStatePropertyAll(DinoLabColorsPalette.transparent),
        backgroundColor: WidgetStatePropertyAll(_colorTheme.secondary.compDark),
      );

  TextStyle get textStyle => _textTheme.headlineMedium.copyWith(
        color: DinoLabColorsPalette.black85,
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
      other is SecondaryButtonTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  SecondaryButtonTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return SecondaryButtonTheme(
        textTheme: textTheme ?? _textTheme,
        colorTheme: colorTheme ?? _colorTheme);
  }

  @override
  ThemeExtension<SecondaryButtonTheme> lerp(
    covariant ThemeExtension<SecondaryButtonTheme>? other,
    double t,
  ) {
    return this;
  }

  static SecondaryButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<SecondaryButtonTheme>()!;
  }
}
