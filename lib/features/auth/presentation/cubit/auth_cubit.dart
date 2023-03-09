import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> register(
      {required String email, required String password}) async {
    try {
      emit(AuthLoading());

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthError(message: 'User is null'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? 'Unknown error occurred'));
    } catch (e) {
      emit(const AuthError(message: 'Unknown error occurred'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthError(message: 'User is null'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? 'Unknown error occurred'));
    } catch (e) {
      emit(const AuthError(message: 'Unknown error occurred'));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}
