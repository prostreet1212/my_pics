import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'auth_text_fields_event.dart';

part 'auth_text_fields_state.dart';

class AuthTextFieldsBloc
    extends Bloc<AuthTextFieldsEvent, AuthTextFieldsState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthTextFieldsBloc()
      : super(const AuthTextFieldsState(
            emailText: 'admin@kdrc.ru', passwordText: '12345678')) {
    emailController.text = state.emailText;
    passwordController.text = state.passwordText;

    on<ChangeEmailEvent>(
        (ChangeEmailEvent event, Emitter<AuthTextFieldsState> emit) {
      emit(state.copyWith(emailText: 'emailText'));
    });
    on<ChangePasswordEvent>(
        (ChangePasswordEvent event, Emitter<AuthTextFieldsState> emit) {
      emit(state.copyWith(passwordText: event.newText));
    });
  }
}
