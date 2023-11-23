part of 'auth_text_fields_bloc.dart';

abstract class AuthTextFieldsEvent extends Equatable {}

class ChangeEmailEvent extends AuthTextFieldsEvent {
  final String newText;

  ChangeEmailEvent({required this.newText});

  @override
  List<Object?> get props => [newText];
}

class ChangePasswordEvent extends AuthTextFieldsEvent {
  final String newText;

  ChangePasswordEvent({required this.newText});

  @override
  List<Object?> get props => [newText];
}
