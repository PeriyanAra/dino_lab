import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
    ),

    AutoRoute(
      page: RegistrationRoute.page,
    ),
    AutoRoute(
      page: LoginRoute.page,
      initial: true,
    ),
  ];
}
