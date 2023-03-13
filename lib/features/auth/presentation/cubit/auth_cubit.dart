import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/navigator/navigation.dart';
import '../../../task/presentation/pages/todo_page.dart';
import '../../domain/use_cases/login_user_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginUserUseCase loginUserUseCase;
  final RegisterUserUseCase registerUserUseCase;

  AuthCubit({
    required this.loginUserUseCase,
    required this.registerUserUseCase,
  }) : super(AuthInitial());

  void checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (user != null) {
          getIt<NavigationService>().pushNamedAndRemoveUntil(TodoPage.routeName);
        } else {
          // user is not logged in
          print('User is not logged in');
        }
      },
    );
  }

  Future<void> register(
      {required String email, required String password}) async {
    emit(AuthLoading());
    final result = await registerUserUseCase(
      email: email,
      password: password,
    );
    result != null
        ? emit(const AuthSuccess())
        : emit(const AuthError(message: "error"));
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    print(state.runtimeType);
    final result = await loginUserUseCase(email: email, password: password);
    result != null
        ? emit(const AuthSuccess())
        : emit(const AuthError(message: "error"));
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}
