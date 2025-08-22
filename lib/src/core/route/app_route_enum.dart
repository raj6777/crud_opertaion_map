enum AppRouteEnum {SplashScreen,GoogleMapPage,TodoListPage,AddTodoListPage,DoctorOnBoardingPage}

extension AppRouteExtension on AppRouteEnum {
  String get path {
    switch (this) {
      case AppRouteEnum.SplashScreen:;
        return "/SplashScreen";
      case AppRouteEnum.GoogleMapPage:
        return "/GoogleMapPage";
      case AppRouteEnum.TodoListPage:
        return "/TodoListPage";
      case AppRouteEnum.AddTodoListPage:
        return "/AddTodoListPage";
      case AppRouteEnum.DoctorOnBoardingPage:
        return "/DoctorOnBoardingPage";
    }
  }
}
