import 'package:auto_route/auto_route.dart';
import 'package:nbp_currency_checker/presentation/routing/app_router.gr.dart';

final appRouter = AppRouter();

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
        ),
      ];
}
