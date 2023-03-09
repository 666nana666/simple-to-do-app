import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpletodoapp/core/di/service_locator.dart';
import 'package:simpletodoapp/core/navigator/navigation.dart';
import 'package:simpletodoapp/core/theme/app_colors.dart';
import 'package:simpletodoapp/core/theme/text_style.dart';
import 'package:simpletodoapp/features/task/presentation/pages/todo_page.dart';

import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'Login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkLoginStatus();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: getIt<AuthCubit>(),
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            getIt<NavigationService>()
                .pushNamedAndRemoveUntil(TodoPage.routeName);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  72.verticalSpace,
                  Text('Login or \nCreate Account',
                      style: AppTextStyle.headingBold34()),
                  32.verticalSpace,
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: AppTextStyle.bodyRegular14(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide:
                            BorderSide(color: AppColors.border, width: 2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide:
                            BorderSide(color: AppColors.border, width: 2.w),
                      ),
                    ),
                  ),
                  22.verticalSpace,
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: AppTextStyle.bodyRegular14(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide:
                            BorderSide(color: AppColors.border, width: 2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide:
                            BorderSide(color: AppColors.border, width: 2.w),
                      ),
                    ),
                  ),
                  32.verticalSpace,
                  InkWell(
                    onTap: () {
                      context.read<AuthCubit>().login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                    },
                    child: Container(
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: buttonDecoration(),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      child: Text('Login',
                          style:
                              AppTextStyle.headingBold16(AppColors.textWhite)),
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          height: 1,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      12.horizontalSpace,
                      Text(
                        'OR',
                        style:
                            AppTextStyle.bodyRegular14(AppColors.textSecondary),
                      ),
                      12.horizontalSpace,
                      const Expanded(
                        child: Divider(
                          height: 1,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  InkWell(
                    onTap: () {
                      context.read<AuthCubit>().register(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                    },
                    child: Container(
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: buttonDecoration(),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      child: Text('Register',
                          style:
                              AppTextStyle.headingBold16(AppColors.textWhite)),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Decoration buttonDecoration() {
    return BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
