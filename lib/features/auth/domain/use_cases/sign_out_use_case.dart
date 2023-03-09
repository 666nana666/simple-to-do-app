import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignOutUserUseCase {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SignOutUserUseCase({required FirebaseAuthRepository firebaseAuthRepository})
      : _firebaseAuthRepository = firebaseAuthRepository;

  Future<void> call() async {
    await _firebaseAuthRepository.signOut();
  }
}
