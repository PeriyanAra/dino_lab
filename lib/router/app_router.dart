import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: EmptyShellRoute('main'),
      path: '/',
      children: [
        AutoRoute(
          page: EmptyShellRoute('authenticated'),
          path: 'authenticated',
          children: [
            AutoRoute(
              initial: true,
              page: HomeRoute.page,
              path: 'home',
            ),
          ],
        ),
        AutoRoute(
          initial: true,
          page: EmptyShellRoute('unauthenticated'),
          path: 'unauthenticated',
          children: [
            AutoRoute(
              page: RegistrationRoute.page,
              path: 'register',
            ),
            AutoRoute(
              initial: true,
              page: LoginRoute.page,
              path: 'login',
            ),
          ],
        ),
      ],
    ),
  ];
}
