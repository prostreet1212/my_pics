part of 'profile_text_fields_bloc.dart';

abstract class ProfileTextFieldsEvent {}

class ChangeProfileNameEvent extends ProfileTextFieldsEvent {
  final String newText;

  ChangeProfileNameEvent({required this.newText});
}

class ChangeProfileEmailEvent extends ProfileTextFieldsEvent {
  final String newText;

  ChangeProfileEmailEvent({required this.newText});
}

class ClearTextFieldsEvent extends ProfileTextFieldsEvent {}
