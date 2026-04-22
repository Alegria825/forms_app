import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthState()) {
    // Al iniciar, revisamos si ya hay un usuario logeado
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
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
      emit(state.copyWith(
        status: AuthStatus.unauthenticated, 
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> logout() async {
    await authRepository.signOut();
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }


  Future<void> updateStudentProfile({
  required String name, 
  required String enrollment
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
    emit(state.copyWith(
      user: updatedUser,
      status: AuthStatus.authenticated,
    ));

  } catch (e) {
    // Manejar el error según tu lógica (podrías emitir un estado de error)
    print("Error en updateStudentProfile: $e");
    rethrow; 
  }
}
}
