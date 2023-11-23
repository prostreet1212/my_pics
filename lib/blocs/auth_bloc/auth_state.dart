part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  success,
  failure,
  loading,
}

class AuthState extends Equatable {
  final String message;
  final AuthStatus authStatus;
  final bool forChanged;
  final ProfileUser? user;
  final AuthStatus checkStatus;
  final AuthStatus completeStatus;

  const AuthState({
    this.message = '',
    this.authStatus = AuthStatus.initial,
    this.forChanged = false,
    this.user,
    this.checkStatus = AuthStatus.loading,
    this.completeStatus = AuthStatus.initial,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    String? message,
    bool? forChanged,
    ProfileUser? user,
    AuthStatus? checkStatus,
    AuthStatus? completeStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
      forChanged: forChanged ?? this.forChanged,
      user: user ?? this.user,
      checkStatus: checkStatus ?? this.checkStatus,
      completeStatus: completeStatus ?? this.completeStatus,
    );
  }

  @override
  List<Object?> get props =>
      [message, authStatus, forChanged, user, checkStatus, completeStatus];
}
