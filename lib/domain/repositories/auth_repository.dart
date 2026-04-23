/*import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential?> loginWithGoogle();
  // Aquí podrías agregar en el futuro:
  //TODO: Future<void> logout();
  //TODO: Stream<User?> authStateChanges();
}
*/


import 'package:forms_app/domain/entities/user_entity.dart';


abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();

  Future<void> updateStudentData({
    required String uid, 
    required String name, 
    required String enrollment
  });

  //Future<void> 
}