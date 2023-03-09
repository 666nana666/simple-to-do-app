import 'package:flutter/material.dart';
import 'package:simpletodoapp/features/task/presentation/pages/todo_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) => MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case LoginPage.routeName:
            return const LoginPage();
          case TodoPage.routeName:
            return const TodoPage();

          default:
            return const TodoPage();
        }
      },
      settings: settings,
    );
