part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignupButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  const SignupButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UpdateNameUserEvent extends AuthEvent {
  final String uid;
  final String newName;

  const UpdateNameUserEvent({required this.uid, required this.newName});
}

class CheckUserEvent extends AuthEvent {}

class ClearUserEvent extends AuthEvent {}

class CompleteRegistration extends AuthEvent {
  final String name;
  final File? avatar;

  const CompleteRegistration({required this.name, required this.avatar});
}

class ChangeAvatarUrlEvent extends AuthEvent {
  final String avatarUrl;

  const ChangeAvatarUrlEvent(this.avatarUrl);
}
