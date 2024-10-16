import 'package:dino_lab/presentation/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/router/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    AppBootstrapper.instance.initialize();
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: DinoLabTheme.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}
