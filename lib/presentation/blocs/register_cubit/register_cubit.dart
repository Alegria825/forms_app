import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Cubit submit: $state');
  }


  void usernameChanged( String value ) {
    final username = Username.dirty(value);

    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([ username, state.password])
      )
    );
  }

  void lastnameChanged( String value ) {
    final lastname = Lastname.dirty(value);

    emit(
      state.copyWith(
        lastname: lastname,
        isValid: Formz.validate([lastname, state.username, state.password])
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
    final enrollment = Enrollment.dirty(value);

    emit(
      state.copyWith(
        enrollment: enrollment,
        isValid: Formz.validate([enrollment, state.username, state.lastname, state.password])
      )
    );
  }

  void passwordChanged( String value ) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username])
      )
    );
  }

}
