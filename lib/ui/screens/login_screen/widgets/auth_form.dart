import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/auth_text_fields_bloc/auth_text_fields_bloc.dart';
import '../../../../blocs/is_login_bloc/is_login_bloc.dart';
import '../../../../routers/app_router.gr.dart';
import '../../../../blocs/auth_bloc/auth_bloc.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthTextFieldsBloc>(
      create: (context) => AuthTextFieldsBloc(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<AuthTextFieldsBloc, AuthTextFieldsState>(
              builder: (context, state) {
            return TextField(
              controller:
                  BlocProvider.of<AuthTextFieldsBloc>(context).emailController,
              style: const TextStyle(color: Colors.white),
              cursorColor: const Color.fromARGB(255, 170, 193, 238),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                border: OutlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 170, 193, 238)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 170, 193, 238),
                  ),
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onChanged: (newValue) {
                BlocProvider.of<AuthTextFieldsBloc>(context)
                    .add(ChangeEmailEvent(newText: newValue));
              },
            );
          }),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthTextFieldsBloc, AuthTextFieldsState>(
              builder: (context, state) {
            return TextField(
              controller: BlocProvider.of<AuthTextFieldsBloc>(context)
                  .passwordController,
              onChanged: (newValue) {
                BlocProvider.of<AuthTextFieldsBloc>(context)
                    .add(ChangePasswordEvent(newText: newValue));
              },
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              cursorColor: const Color.fromARGB(255, 170, 193, 238),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                border: OutlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 170, 193, 238)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 170, 193, 238),
                  ),
                ),
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }),
          const SizedBox(
            height: 40,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (prev, next) =>
                next.completeStatus == AuthStatus.initial,
            listener: (context, authState) {
              if (authState.authStatus == AuthStatus.success) {
                if (authState.message == 'login') {
                  if (kDebugMode) {
                    print('COMPLETED');
                  }
                  AutoRouter.of(context).replace(const MainRoute());
                } else if ((authState.user!.name ==
                    '') /*&&authState.completeStatus==AuthStatus.initial*/) {
                  AutoRouter.of(context).push(const RegCompleteRoute());
                }
              }
              if (authState.authStatus == AuthStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState.message),
                  ),
                );
              }
            },
            builder: (context, authState) {
              return BlocBuilder<IsLoginBloc, IsLoginState>(
                  builder: (context, state) {
                bool isLogin = state.isLogin;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 201, 202, 203),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    backgroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: authState.authStatus == AuthStatus.loading
                      ? null
                      : () async {
                          String email =
                              BlocProvider.of<AuthTextFieldsBloc>(context)
                                  .emailController
                                  .text;
                          String password =
                              BlocProvider.of<AuthTextFieldsBloc>(context)
                                  .passwordController
                                  .text;
                          if (!isLogin) {
                            BlocProvider.of<AuthBloc>(context).add(
                                SignupButtonPressedEvent(
                                    email: email, password: password));
                          } else {
                            BlocProvider.of<AuthBloc>(context).add(
                                LoginButtonPressedEvent(
                                    email: email, password: password));
                          }
                        },
                  child: authState.authStatus != AuthStatus.loading
                      ? Text(
                          isLogin ? 'Войти' : 'Регистрация',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.blueAccent),
                        )
                      : const CircularProgressIndicator(),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
