abstract class FirebaseAuthRepository {
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
