import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) => MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case LoginPage.routeName:
            return const LoginPage();

          default:
            return const LoginPage();
        }
      },
      settings: settings,
    );
