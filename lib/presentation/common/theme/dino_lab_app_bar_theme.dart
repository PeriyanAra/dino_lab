import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class DinoLabAppBarTheme extends ThemeExtension<DinoLabAppBarTheme> {
  const DinoLabAppBarTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  })  : _colorTheme = colorTheme,
        _textTheme = textTheme;

  final DinoLabColorTheme _colorTheme;
  final DinoLabTextTheme _textTheme;

  Color get backgroundColor => _colorTheme.primary;
  TextStyle get titleTextStyle => _textTheme.titleLarge.copyWith(
        fontSize: 25,
        color: _colorTheme.backgroundPrimary,
      );

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        _textTheme,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinoLabAppBarTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  DinoLabAppBarTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return DinoLabAppBarTheme(
      textTheme: textTheme ?? _textTheme,
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<DinoLabAppBarTheme> lerp(
    covariant ThemeExtension<DinoLabAppBarTheme>? other,
    double t,
  ) {
    return this;
  }

  static DinoLabAppBarTheme of(BuildContext context) {
    return Theme.of(context).extension<DinoLabAppBarTheme>()!;
  }
}
