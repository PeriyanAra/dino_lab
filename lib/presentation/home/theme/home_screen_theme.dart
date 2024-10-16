import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class HomeScreenTheme extends ThemeExtension<HomeScreenTheme> {
  const HomeScreenTheme({
    required DinoLabColorTheme colorTheme,
    required DinoLabTextTheme textTheme,
  })  : _colorTheme = colorTheme,
        _textTheme = textTheme;

  final DinoLabColorTheme _colorTheme;
  final DinoLabTextTheme _textTheme;

  TextStyle get userNameTextStyle =>
      _textTheme.titleLarge.copyWith(fontSize: 40.0);
  TextStyle get userEmailTextStyle =>
      _textTheme.displaySmall.copyWith(fontWeight: FontWeight.w300);
  double get logoutButtonWidth => 200.0;
  double get logoutButtonHeight => 50.0;
  double get spaceBetweenAvatarAndUserName => 15.0;
  EdgeInsets get errorContentPadding => EdgeInsets.all(16);

  @override
  int get hashCode => Object.hash(
        _colorTheme,
        _textTheme,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeScreenTheme &&
          runtimeType == other.runtimeType &&
          _textTheme == other._textTheme &&
          _colorTheme == other._colorTheme;

  @override
  HomeScreenTheme copyWith({
    DinoLabColorTheme? colorTheme,
    DinoLabTextTheme? textTheme,
  }) {
    return HomeScreenTheme(
        textTheme: textTheme ?? _textTheme,
        colorTheme: colorTheme ?? _colorTheme);
  }

  @override
  ThemeExtension<HomeScreenTheme> lerp(
    covariant ThemeExtension<HomeScreenTheme>? other,
    double t,
  ) {
    return this;
  }

  static HomeScreenTheme of(BuildContext context) {
    return Theme.of(context).extension<HomeScreenTheme>()!;
  }
}
