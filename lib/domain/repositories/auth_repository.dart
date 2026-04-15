import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential?> loginWithGoogle();
  // Aquí podrías agregar en el futuro:
  //TODO: Future<void> logout();
  //TODO: Stream<User?> authStateChanges();
}
