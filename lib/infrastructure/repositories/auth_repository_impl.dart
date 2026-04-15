import 'package:firebase_auth/firebase_auth.dart';
import 'package:forms_app/domain/datasources/auth_datasource.dart';
import 'package:forms_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserCredential?> loginWithGoogle() {
    return datasource.signInWithGoogle();
  }
}
