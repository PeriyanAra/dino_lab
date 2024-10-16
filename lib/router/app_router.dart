import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    // AutoRoute(
    //   page: EmptyShellRoute('authenticated'),
    //   children: [
        AutoRoute(
          initial: true,
          page: HomeRoute.page,
        ),
    //   ],
    // ),
    // AutoRoute(
    //   initial: true,
    //   page: EmptyShellRoute('unauthenticated'),
    //   children: [
        AutoRoute(
          page: RegistrationRoute.page,
        ),
        AutoRoute(
          initial: true,
          page: LoginRoute.page,
        ),
      // ],
    // ),
  ];
}
