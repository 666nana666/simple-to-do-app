
import '../di/service_locator.dart';
import 'navigation.dart';

void appLinkNavigation(Uri uri) async {
  var nav = getIt<NavigationService>();

  switch (uri.path) {
    // case '/change/phone':
    //   await nav.goToVerifyId();
    //   break;
    // case '/edit-profile':
    //   getIt<DashboardCubit>().changeIndex(2);
    //   nav.popUntil(DashboardPage.routeName);
    //   break;
    // case '/home':
    //   nav.popUntil(DashboardPage.routeName);
    //   break;
    default:
      await nav.pushNamed(uri.path);
  }
}
