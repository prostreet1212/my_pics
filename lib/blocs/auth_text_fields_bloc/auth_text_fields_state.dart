part of 'auth_text_fields_bloc.dart';

class AuthTextFieldsState extends Equatable {
  final String emailText;
  final String passwordText;

  const AuthTextFieldsState({this.emailText = '', this.passwordText = ''});

  @override
  List<Object> get props => [emailText, passwordText];

  AuthTextFieldsState copyWith({String? emailText, String? passwordText}) {
    return AuthTextFieldsState(
      emailText: emailText ?? this.emailText,
      passwordText: passwordText ?? this.passwordText,
    );
  }
}
