part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final Lastname lastname;
  final Email email;
  final Enrollment enrollment;
  final Password password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.username = const Username.pure(),
    this.lastname = const Lastname.pure(),
    this.email = const Email.pure(),
    this.enrollment = const Enrollment.pure(),
    this.password = const Password.pure(),
  });

  RegisterFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Username? username,
    Lastname? lastname,
    Email? email,
    Enrollment? enrollment,
    Password? password,
  }) => RegisterFormState(
    formStatus: formStatus ?? this.formStatus,
    isValid: isValid ?? this.isValid,
    username: username ?? this.username,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    enrollment: enrollment ?? this.enrollment,
    password: password ?? this.password,
  );

  @override
  List<Object> get props => [
    formStatus,
    isValid,
    username,
    lastname,
    email,
    enrollment,
    password,
  ];
}
