import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthState()) {
    // Al iniciar, revisamos si ya hay un usuario logeado
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    // 1. Verificamos si hay una sesión activa en Firebase Auth
    final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      // 2. Si hay sesión, buscamos los datos extendidos en Firestore (incluyendo enrollment)
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data()!;
          final user = UserEntity(
            uid: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: data['name'] ?? firebaseUser.displayName ?? '',
            role: data['role'] ?? 'student',
            enrollment: data['enrollment'], // Recuperamos la matrícula guardada
          );

          emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        } else {
          // Si por alguna razón el doc no existe, lo tratamos como no autenticado o nuevo
          emit(state.copyWith(status: AuthStatus.unauthenticated));
        }
      } catch (e) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> login() async {
    emit(state.copyWith(status: AuthStatus.checking));
    try {
      final user = await authRepository.signInWithGoogle();
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    await authRepository.signOut();
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }

  Future<void> updateStudentProfile({
    required String name,
    required String enrollment,
  }) async {
    // 1. Obtenemos el usuario actual del estado
    final currentUser = state.user;
    if (currentUser == null) return;

    try {
      // 2. Notificamos que estamos procesando (opcional, si tienes un status de carga)
      // emit(state.copyWith(status: AuthStatus.checking));

      // 3. Guardamos en Firestore a través del repositorio
      await authRepository.updateStudentData(
        uid: currentUser.uid,
        name: name,
        enrollment: enrollment,
      );

      // 4. Creamos una copia del objeto usuario con los nuevos datos
      // Asegúrate de que tu clase 'User' tenga el método copyWith
      final updatedUser = currentUser.copyWith(
        name: name,
        enrollment: enrollment,
      );

      // 5. Emitimos el nuevo estado con el usuario actualizado
      // ¡ESTO ES LO QUE DISPARA EL REDIRECT DEL GOROUTER!
      emit(state.copyWith(user: updatedUser, status: AuthStatus.authenticated));
    } catch (e) {
      // Manejar el error según tu lógica (podrías emitir un estado de error)
      //print("Error en updateStudentProfile: $e");
      rethrow;
    }
  }

}
