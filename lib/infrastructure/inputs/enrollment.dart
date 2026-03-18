
import 'package:formz/formz.dart';

// Define input validation errors
enum EnrollmentError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Enrollment extends FormzInput<String, EnrollmentError> {
  // Call super.pure to represent an unmodified form input.
  const Enrollment.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Enrollment.dirty(String value) : super.dirty(value);

  String? get errorMessage {

    if (isValid || isPure) return null;
    if (displayError == EnrollmentError.empty) return 'Campo requerido';
    if (displayError == EnrollmentError.length) return 'Minimo 10 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EnrollmentError? validator(String value) {
    
    if (value.length < 10) return EnrollmentError.length;
    if (value.isEmpty || value.trim().isEmpty) return EnrollmentError.empty;

    return null;
  }
}
