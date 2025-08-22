// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:googlemap/src/features/doctor_list/DoctorOnboarding.dart'
    as _i2;
import 'package:googlemap/src/features/googl_map/GoogleMapPage.dart' as _i3;
import 'package:googlemap/src/features/splash/splash_screen.dart' as _i4;
import 'package:googlemap/src/features/todo/AddTodoListPage.dart' as _i1;
import 'package:googlemap/src/features/todo/bloc/objectbox/ObjectBox.dart'
    as _i8;
import 'package:googlemap/src/features/todo/TodoListPage.dart' as _i5;

abstract class $AppAutoRouter extends _i6.RootStackRouter {
  $AppAutoRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AddTodoListRoute.name: (routeData) {
      final args = routeData.argsAs<AddTodoListRouteArgs>(
          orElse: () => const AddTodoListRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddTodoListPage(
          key: args.key,
          taskToEdit: args.taskToEdit,
        ),
      );
    },
    DoctorOnBoardingRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DoctorOnBoardingPage(),
      );
    },
    GoogleMapRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GoogleMapPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashScreen(),
      );
    },
    TodoListRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TodoListPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddTodoListPage]
class AddTodoListRoute extends _i6.PageRouteInfo<AddTodoListRouteArgs> {
  AddTodoListRoute({
    _i7.Key? key,
    _i8.Task? taskToEdit,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          AddTodoListRoute.name,
          args: AddTodoListRouteArgs(
            key: key,
            taskToEdit: taskToEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTodoListRoute';

  static const _i6.PageInfo<AddTodoListRouteArgs> page =
      _i6.PageInfo<AddTodoListRouteArgs>(name);
}

class AddTodoListRouteArgs {
  const AddTodoListRouteArgs({
    this.key,
    this.taskToEdit,
  });

  final _i7.Key? key;

  final _i8.Task? taskToEdit;

  @override
  String toString() {
    return 'AddTodoListRouteArgs{key: $key, taskToEdit: $taskToEdit}';
  }
}

/// generated route for
/// [_i2.DoctorOnBoardingPage]
class DoctorOnBoardingRoute extends _i6.PageRouteInfo<void> {
  const DoctorOnBoardingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DoctorOnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorOnBoardingRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GoogleMapPage]
class GoogleMapRoute extends _i6.PageRouteInfo<void> {
  const GoogleMapRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GoogleMapRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoogleMapRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TodoListPage]
class TodoListRoute extends _i6.PageRouteInfo<void> {
  const TodoListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TodoListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoListRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
