import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseAuthDataSource {


  Future<String?> loginUser(String email, String password);

  Future<String?> registerUser(String email, String password) ;

  Future<void> signOutUser();
}

@LazySingleton(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImpl extends FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuthDataSourceImpl();


  @override
  Future<String?> loginUser(String email, String password) async {
    try {
      final userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<String?> registerUser(String email, String password) async {
    try {
      final userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }
}
