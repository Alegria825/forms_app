
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forms_app/domain/entities/user_entity.dart';

import '../../domain/datasources/auth_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> getCurrentUser() {
    return dataSource.getCurrentUser();
  }

  @override
  Future<UserEntity> signInWithGoogle() {
    return dataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  Future<void> updateStudentData({
  required String uid, 
  required String name, 
  required String enrollment
}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
          'name': name,
          'enrollment': enrollment,
        });
  } catch (e) {
    throw Exception('Error al actualizar el perfil en base de datos: $e');
  }
}

}


// En tu AuthRepository o AuthRepositoryImpl
