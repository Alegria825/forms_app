import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Cubit submit: $state');
  }


  void usernameChanged( String value ) {
    emit(
      state.copyWith(
        username: value,
      )
    );
  }

  void lastnameChanged( String value ) {
    emit(
      state.copyWith(
        lastname: value,
      )
    );
  }

  void emailChanged( String value ) {
    emit(
      state.copyWith(
        email: value,
      )
    );
  }

  void enrollmentChanged( String value ) {
    emit(
      state.copyWith(
        enrollment: value,
      )
    );
  }

  void passwordChanged( String value ) {
    emit(
      state.copyWith(
        password: value,
      )
    );
  }

}
