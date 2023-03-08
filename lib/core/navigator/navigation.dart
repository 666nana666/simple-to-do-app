import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class Navigation {
  /* Navigate to new page */
  Future<T?> navigateTo<T>(Widget newPage, [String? routeName]);

  /* Push to new route */
  Future<T?> pushRoute<T>(ModalRoute<T> route, [String? routeName]);

  /* Pop the page */
  void pop<T>({T? result, VoidCallback? callback});

  /* Pop the page until designated page */
  void popUntil(String? routeName);
}

@LazySingleton()
class NavigationService implements Navigation {
  /* Create GlobalKey to be used in navigation */

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push to a new page
  Future<T?> push<T>(Widget widget, [String? routeName]) async =>
      navigatorKey.currentState!.push<T>(
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => widget,
          settings: RouteSettings(name: routeName),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (c, animation, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      );

  /// Push to a new page
  Future<T?> pushSlideUp<T>(Widget widget, [String? routeName]) async =>
      navigatorKey.currentState!.push<T>(
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => widget,
          settings: RouteSettings(name: routeName),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (c, animation, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      );
  /// Push to a new page
  Future<T?> pushSwipeUp<T>(Widget widget, [String? routeName]) async =>
      navigatorKey.currentState!.push<T>(
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => widget,
          settings: RouteSettings(name: routeName),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (c, animation, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      );

  /// Push to a new page
  Future<T?> pushAndRemoveUntil<T>(Widget widget, RoutePredicate predicate,
          [String? routeName]) async =>
      navigatorKey.currentState!.pushAndRemoveUntil<T>(
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => widget,
          settings: RouteSettings(name: routeName),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (c, animation, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        predicate,
      );

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      );

  /// Push to a new page (replace the stack)
  Future<T?> pushReplacement<T, K>(Widget widget, [String? routeName]) async =>
      navigatorKey.currentState!.pushReplacement<T, K>(
        MaterialPageRoute(
          builder: (_) => widget,
          settings: RouteSettings(name: routeName),
        ),
      );

  Future<T?> pushReplacementNamed<T, K>(String routeName,
          {Object? arguments}) async =>
      navigatorKey.currentState!.pushReplacementNamed<T, K>(
        routeName,
        arguments: arguments,
      );

  Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
    RoutePredicate? until,
  }) {
    var predicate = until ?? (route) => false;
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  @override
  Future<T?> pushRoute<T>(Route<T> route, [String? routeName]) =>
      navigatorKey.currentState!.push<T>(route);

  @override
  void pop<T>({T? result, VoidCallback? callback}) {
    navigatorKey.currentState!.maybePop<T>().then((value) => callback);
  }

  @override
  Future<T?> navigateTo<T>(Widget newPage, [String? routeName]) =>
      push<T>(newPage, routeName!);

  @override
  void popUntil(String? routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName!));
  }
}
