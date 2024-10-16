import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dino_lab/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en')],
      path: 'assets/translations', // <-- Change the path of the translation files
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: const App(),
    ),
  );
}
