import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/ui/screens/login_screen/widgets/auth_form.dart';
import 'package:my_pics/ui/screens/login_screen/widgets/question_widget.dart';
import '../../../blocs/is_login_bloc/is_login_bloc.dart';
import '../../../routers/app_router.gr.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('login screen build');
    }
    return Scaffold(
      body: BlocProvider<IsLoginBloc>(
        create: (context) => IsLoginBloc(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 24, 136, 240),
              Color.fromARGB(255, 65, 54, 178),
            ],
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 100, bottom: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 176,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 176,
                      //width: 120,
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, authState) {
                      if (authState.checkStatus == AuthStatus.success) {
                        AutoRouter.of(context).replace(const MainRoute());
                      }
                    },
                    builder: (context, authState) {
                      return authState.checkStatus == AuthStatus.loading
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                  child: SpinKitCubeGrid(
                                size: 60,
                                itemBuilder: (BuildContext context, int index) {
                                  return const DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                    ),
                                  );
                                },
                              )),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 11,
                                ),
                                const AuthForm(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4.8,
                                ),
                                const QuestionWidget(),
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
