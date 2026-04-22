
/*
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<UserCredential?> signInWithGoogle();

  //TODO: Aquí podrías agregar en el futuro: Future<void> logout();
}
*/

import 'package:forms_app/domain/entities/user_entity.dart';

abstract class AuthDataSource {
  /// Revisa si ya hay una sesión activa y trae los datos de Firestore
  Future<UserEntity?> getCurrentUser();
  
  /// Inicia sesión con Google y maneja la lógica de la Whitelist
  Future<UserEntity> signInWithGoogle();
  
  /// Cierra la sesión
  Future<void> signOut();
}


