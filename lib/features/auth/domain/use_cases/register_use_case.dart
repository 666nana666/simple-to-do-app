import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class RegisterUserUseCase {
  final FirebaseAuthRepository _firebaseAuthRepository;

  RegisterUserUseCase({required FirebaseAuthRepository firebaseAuthRepository})
      : _firebaseAuthRepository = firebaseAuthRepository;

  Future<String?> call(
      {required String email, required String password}) async {
    final result = await _firebaseAuthRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }
}
