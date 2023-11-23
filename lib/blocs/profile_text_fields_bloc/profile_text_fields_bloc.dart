import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'profile_text_fields_event.dart';

part 'profile_text_fields_state.dart';

class ProfileTextFieldsBloc
    extends Bloc<ProfileTextFieldsEvent, ProfileTextFieldsState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ProfileTextFieldsBloc()
      : super(const ProfileTextFieldsState(nameText: '', emailText: '')) {
    nameController.text = state.nameText;
    emailController.text = state.emailText;

    on<ChangeProfileNameEvent>(
        (ChangeProfileNameEvent event, Emitter<ProfileTextFieldsState> emit) {
      emit(state.copyWith(nameText: event.newText));
    });
    on<ChangeProfileEmailEvent>(
        (ChangeProfileEmailEvent event, Emitter<ProfileTextFieldsState> emit) {
      emit(state.copyWith(emailText: event.newText));
    });
    on<ClearTextFieldsEvent>(
        (ClearTextFieldsEvent event, Emitter<ProfileTextFieldsState> emit) {
      nameController.text = '';
      emailController.text = '';

      emit(const ProfileTextFieldsState());
    });
  }
}
