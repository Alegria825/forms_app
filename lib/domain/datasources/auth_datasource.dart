

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<UserCredential?> signInWithGoogle();

  //TODO: Aquí podrías agregar en el futuro: Future<void> logout();
}


/*
import 'package:forms_app/domain/entities/user.dart';

abstract class AuthDataSource {
  /// Revisa si ya hay una sesión activa y trae los datos de Firestore
  Future<User?> getCurrentUser();
  
  /// Inicia sesión con Google y maneja la lógica de la Whitelist
  Future<User> signInWithGoogle();
  
  /// Cierra la sesión
  Future<void> signOut();
}

*/
