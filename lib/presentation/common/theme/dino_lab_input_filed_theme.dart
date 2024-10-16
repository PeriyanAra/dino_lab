import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class DinoLabInputFieldTheme extends ThemeExtension<DinoLabInputFieldTheme> {
  const DinoLabInputFieldTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  })  : _colorTheme = colorTheme,
        _textTheme = textTheme;

  final DinoLabColorTheme _colorTheme;
  final DinoLabTextTheme _textTheme;

  OutlineInputBorder get enabledBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: DinoLabColorsPalette.black35,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  OutlineInputBorder get focusedBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: DinoLabColorsPalette.primaryActive,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  OutlineInputBorder get errorBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: DinoLabColorsPalette.errorActive,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  ColorFilter get hideIconColorFilter => ColorFilter.mode(
        DinoLabColorsPalette.black35,
        BlendMode.srcIn,
      );

  TextStyle get hintTextStyle =>
      _textTheme.headlineMedium.copyWith(color: DinoLabColorsPalette.black60);

  TextStyle get emptyErrorTextStyle =>
      _textTheme.headlineMedium.copyWith(fontSize:0.0);

  TextStyle get primaryTextStyle => _textTheme.headlineMedium;

  double get hideIconSize => 10.0;

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        _textTheme,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinoLabInputFieldTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  DinoLabInputFieldTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return DinoLabInputFieldTheme(
      textTheme: textTheme ?? _textTheme,
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<DinoLabInputFieldTheme> lerp(
    covariant ThemeExtension<DinoLabInputFieldTheme>? other,
    double t,
  ) {
    return this;
  }

  static DinoLabInputFieldTheme of(BuildContext context) {
    return Theme.of(context).extension<DinoLabInputFieldTheme>()!;
  }
}
