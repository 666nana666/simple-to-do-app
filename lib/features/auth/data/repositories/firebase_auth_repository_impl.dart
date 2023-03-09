import 'package:injectable/injectable.dart';
import 'package:simpletodoapp/features/auth/domain/repositories/firebase_auth_repository.dart';

import '../data_sources/firebase_auth_data_source.dart';

@LazySingleton(as: FirebaseAuthRepository)
class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  FirebaseAuthRepositoryImpl(
      {required FirebaseAuthDataSource firebaseAuthDataSource})
      : _firebaseAuthDataSource = firebaseAuthDataSource;

  @override
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuthDataSource.loginUser(email, password);
    return result;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthDataSource.signOutUser();
  }

  @override
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuthDataSource.registerUser(email, password);
    return result;
  }
}
