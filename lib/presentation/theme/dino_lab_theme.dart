import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';
import 'package:dino_lab/presentation/theme/index.dart';

class DinoLabTheme {
  static ThemeData light() {
    final colorTheme = _lightColorTheme();
    final textTheme = DinoLabTextTheme(colorTheme: colorTheme);
    final primaryButtonTheme = PrimaryButtonTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );

    final secondaryButtonTheme = SecondaryButtonTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );
    final dinoLabInputFieldTheme = DinoLabInputFieldTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );
    final authScreensTheme = AuthScreensTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );
    final overlayLoaderHelperTheme = OverlayLoaderHelperTheme(
      colorTheme: colorTheme,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorTheme.primary,
      ),
      applyElevationOverlayColor: false,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: colorTheme.backgroundPrimary,
      extensions: <ThemeExtension<dynamic>>[
        colorTheme,
        textTheme,
        primaryButtonTheme,
        secondaryButtonTheme,
        dinoLabInputFieldTheme,
        authScreensTheme,
        overlayLoaderHelperTheme,
      ],
      textTheme: TextTheme(),
    );
  }

  static ThemeData dark() {
    final colorTheme = _darkColorTheme();
    final textTheme = DinoLabTextTheme(colorTheme: colorTheme);
    final primaryButtonTheme = PrimaryButtonTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );

    final secondaryButtonTheme = SecondaryButtonTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );

    final dinoLabInputFieldTheme = DinoLabInputFieldTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );
    final authScreensTheme = AuthScreensTheme(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );
    final overlayLoaderHelperTheme = OverlayLoaderHelperTheme(
      colorTheme: colorTheme,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorTheme.primary,
      ),
      applyElevationOverlayColor: false,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: colorTheme.backgroundPrimary,
      extensions: <ThemeExtension<dynamic>>[
        colorTheme,
        textTheme,
        primaryButtonTheme,
        secondaryButtonTheme,
        dinoLabInputFieldTheme,
        authScreensTheme,
        overlayLoaderHelperTheme,
      ],
    );
  }

  static DinoLabColorTheme _lightColorTheme() {
    return _baseColorTheme(
      brightness: Brightness.light,
    );
  }

  static DinoLabColorTheme _darkColorTheme() {
    return _baseColorTheme(
      brightness: Brightness.dark,
    );
  }

  /////////////////////////////////////////////////////////////////
  /************************* BASE ********************************/
  /////////////////////////////////////////////////////////////////

  static DinoLabColorTheme _baseColorTheme({
    required Brightness brightness,
  }) {
    return DinoLabColorTheme(
      brightness: Brightness.light,
      primary: DinoLabColor(
        DinoLabColorsPalette.primaryBase.value,
        active: DinoLabColorsPalette.primaryActive,
        compLight: DinoLabColorsPalette.primaryCompLight,
        compDark: DinoLabColorsPalette.primaryCompDark,
      ),
      secondary: DinoLabColor(
        DinoLabColorsPalette.secondaryBase.value,
        active: DinoLabColorsPalette.secondaryActive,
        compLight: DinoLabColorsPalette.secondaryCompLight,
        compDark: DinoLabColorsPalette.secondaryCompDark,
      ),
      error: DinoLabColor(
        DinoLabColorsPalette.errorBase.value,
        active: DinoLabColorsPalette.errorActive,
        compLight: DinoLabColorsPalette.errorComp,
      ),
      warning: DinoLabColor(
        DinoLabColorsPalette.warningBase.value,
        active: DinoLabColorsPalette.warningActive,
        compLight: DinoLabColorsPalette.warningComp,
      ),
      success: DinoLabColor(
        DinoLabColorsPalette.successBase.value,
        active: DinoLabColorsPalette.successActive,
        compLight: DinoLabColorsPalette.successComp,
      ),
      backgroundPrimary: DinoLabColor(
        DinoLabColorsPalette.white100.value,
      ),
    );
  }
}
