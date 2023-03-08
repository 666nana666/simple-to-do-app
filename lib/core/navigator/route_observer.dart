import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../log/log.dart';
import '../messenger/messenger.dart';

final GlobalNavigatorObserver mainRouteObserver = GlobalNavigatorObserver();

class GlobalNavigatorObserver extends RouteObserver<ModalRoute<Object?>>
    implements NavigatorObserver {
  Log get log => getIt<Log>();

  void _setLog(String msg) {
    log.console('Navigation $msg');
  }

  void _hideSnackbar() =>
      getIt<MessengerService>().rootScaffoldMessengerKey.currentState
        ?..hideCurrentSnackBar();

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    var newRouteName = route.settings.name;
    var prevRouteName = previousRoute?.settings.name;

    _setLog('pop from $prevRouteName to $newRouteName');
    _hideSnackbar();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    var newRouteName = route.settings.name;
    var prevRouteName = previousRoute?.settings.name;

    _setLog('push from $prevRouteName to $newRouteName');
    _hideSnackbar();
  }
}
