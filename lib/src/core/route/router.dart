import 'package:auto_route/auto_route.dart';
import 'package:googlemap/src/core/route/router.gr.dart';
import 'package:googlemap/src/features/doctor_list/DoctorOnboarding.dart';
import 'app_route_enum.dart';

@AutoRouterConfig()
class AppAutoRouter extends $AppAutoRouter{
@override
List<AutoRoute> get routes =>[
  AutoRoute(
      path: AppRouteEnum.SplashScreen.path,
      page: SplashRoute.page,
      initial: true),
  AutoRoute(
      path: AppRouteEnum.GoogleMapPage.path,
      page: GoogleMapRoute.page),
  AutoRoute(
      path: AppRouteEnum.TodoListPage.path,
      page: TodoListRoute.page),
  AutoRoute(
      path: AppRouteEnum.AddTodoListPage.path,
      page: AddTodoListRoute.page),
  AutoRoute(
    path: AppRouteEnum.DoctorOnBoardingPage.path,
    page: DoctorOnBoardingRoute.page),
];
  }