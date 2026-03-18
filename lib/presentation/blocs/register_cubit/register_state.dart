part of 'register_cubit.dart';


enum FormStatus {invalid , valid, validating, posting }


class RegisterFormState extends Equatable {

  final FormStatus formStatus;
  final String username;
  final String lastname;
  final String email;
  final String enrollment;
  final String password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid, 
    this.username = '', 
    this.lastname = '', 
    this.email = '', 
    this.enrollment = '', 
    this.password = ''
    });

  RegisterFormState copyWith({
    FormStatus? formStatus,
    String? username,
    String? lastname,
    String? email,
    String? enrollment,
    String? password,
  }) => RegisterFormState(
    formStatus: formStatus  ?? this.formStatus,
    username: username  ?? this.username,
    lastname: lastname  ?? this.lastname,
    email: email  ?? this.email,
    enrollment: enrollment  ?? this.enrollment,
    password: password  ?? this.password,    
  );


  @override
  List<Object> get props => [ formStatus, username, lastname, email, enrollment, password];
}

