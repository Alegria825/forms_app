import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<UserCredential?> signInWithGoogle();

  //TODO: Aquí podrías agregar en el futuro: Future<void> logout();
}
