import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {

    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        username: Username.dirty(state.username.value),
        lastname: Lastname.dirty(state.lastname.value),
        enrollment: Enrollment.dirty(state.enrollment.value),
        email: Email.dirty(state.email.value),
        password: Password.dirty(state.password.value),
        isValid: Formz.validate([
          state.username,
          state.lastname,
          state.enrollment,
          //TODO: state.email,
          state.password,
        ])
        
      )
    );

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
        isValid: Formz.validate([lastname, state.username, state.password, state.enrollment])
      )
    );
  }

  void emailChanged( String value ) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.username, state.lastname, state.enrollment, state.password])
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
        isValid: Formz.validate([password, state.username, state.enrollment, state.lastname])
      )
    );
  }

}
