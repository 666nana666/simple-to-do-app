import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpletodoapp/features/auth/presentation/pages/login_page.dart';
import 'package:simpletodoapp/features/task/presentation/cubit/todo_cubit.dart';
import 'package:simpletodoapp/features/task/presentation/pages/todo_page.dart';

import 'core/di/service_locator.dart';
import 'core/log/log.dart';
import 'core/messenger/messenger.dart';
import 'core/navigator/generate_route.dart';
import 'core/navigator/navigation.dart';
import 'core/navigator/route_observer.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async => runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        configureDependencies();
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);

        runApp(MultiBlocProvider(providers: [
          BlocProvider<AuthCubit>(
            create: (context) => getIt<AuthCubit>(),
            lazy: false,
          ),
          BlocProvider<TodoCubit>(
            create: (context) => getIt<TodoCubit>(),
            lazy: false,
          ),
        ], child: const SimpleToDoApp()));
      },
      (exception, stackTrace) async {
        getIt<Log>().console(
          exception.toString(),
          stackTrace: stackTrace,
        );
      },
    );

class SimpleToDoApp extends StatefulWidget {
  const SimpleToDoApp({Key? key}) : super(key: key);

  @override
  State<SimpleToDoApp> createState() => _SimpleToDoAppState();
}

class _SimpleToDoAppState extends State<SimpleToDoApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(
          360,
          794,
        ),
        builder: (context, child) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            color: AppColors.primary,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            onGenerateRoute: generateRoute,
            onGenerateInitialRoutes: ((initialRoute) {
              return [
                generateRoute(
                  const RouteSettings(
                    name: TodoPage.routeName,
                  ),
                ),
              ];
            }),
            navigatorObservers: [
              mainRouteObserver,
            ],
            navigatorKey: getIt<NavigationService>().navigatorKey,
            scaffoldMessengerKey:
                getIt<MessengerService>().rootScaffoldMessengerKey,
          );
        });
  }
}
