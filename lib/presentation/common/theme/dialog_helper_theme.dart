import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class DialogHelperTheme extends ThemeExtension<DialogHelperTheme> {
  const DialogHelperTheme({
    required DinoLabColorTheme colorTheme,
  }) : _colorTheme = colorTheme;

  final DinoLabColorTheme _colorTheme;

  EdgeInsets get dialogInsetPadding => EdgeInsets.all(20.0);
  EdgeInsets get dialogContentPadding => EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      );

  BoxDecoration get dialogContentDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      );

  double get dialogContentSpace => 10.0;

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        this,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DialogHelperTheme &&
          runtimeType == other.runtimeType &&
          _colorTheme == other._colorTheme;

  @override
  DialogHelperTheme copyWith({
    DinoLabColorTheme? colorTheme,
  }) {
    return DialogHelperTheme(
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<DialogHelperTheme> lerp(
    covariant ThemeExtension<DialogHelperTheme>? other,
    double t,
  ) {
    return this;
  }

  static DialogHelperTheme of(BuildContext context) {
    return Theme.of(context).extension<DialogHelperTheme>()!;
  }
}
