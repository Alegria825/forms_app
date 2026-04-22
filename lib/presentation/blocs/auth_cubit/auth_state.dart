import '../../../domain/entities/user_entity.dart';

enum AuthStatus { checking, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String errorMessage;

  AuthState({
    this.status = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  // Método copyWith para no mutar el estado original
  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) => AuthState(
    status: status ?? this.status,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}