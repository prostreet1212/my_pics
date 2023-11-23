part of 'profile_text_fields_bloc.dart';

class ProfileTextFieldsState extends Equatable {
  final String nameText;
  final String emailText;

  const ProfileTextFieldsState({this.nameText = '', this.emailText = ''});

  @override
  List<Object> get props => [nameText, emailText];

  ProfileTextFieldsState copyWith({String? nameText, String? emailText}) {
    return ProfileTextFieldsState(
      nameText: nameText ?? this.nameText,
      emailText: emailText ?? this.emailText,
    );
  }
}
