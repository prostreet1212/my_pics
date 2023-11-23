part of 'is_login_bloc.dart';

class IsLoginState extends Equatable {
  final bool isLogin;

  const IsLoginState({this.isLogin = true});

  IsLoginState copyWith(bool? isLogin) {
    return IsLoginState(isLogin: isLogin ?? this.isLogin);
  }

  @override
  List<Object?> get props => [isLogin];
}
