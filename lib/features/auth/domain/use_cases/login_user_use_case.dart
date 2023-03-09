import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class LoginUserUseCase {
  final FirebaseAuthRepository _firebaseAuthRepository;

  LoginUserUseCase({required FirebaseAuthRepository firebaseAuthRepository})
      : _firebaseAuthRepository = firebaseAuthRepository;

  Future<String?> call(
      {required String email, required String password}) async {
    final result = await _firebaseAuthRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }
}
