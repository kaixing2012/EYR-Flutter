import 'package:eyr/apn/app_routes.dart';
import 'package:eyr/featured/auth/login/login_view.dart';
import 'package:go_router/go_router.dart';

final authRouter = ShellRoute(
  builder: (context, state, child) => child,
  routes: [
    GoRoute(
      path: '/${AppRoutes.auth.path}',
      name: AppRoutes.auth.name,
      redirect: (context, state) => null,
      routes: [
        GoRoute(
          path: AppRoutes.auth.login.path,
          name: AppRoutes.auth.login.name,
          builder: (context, state) {
            final extra = state.extra;

            if (extra is! LoginRouteParam) {
              throw Exception('LoginRouteParam');
            }

            return LoginView(
              redirectUrl: extra.redirectUrl,
            );
          },
        ),
      ],
    ),
  ],
);
