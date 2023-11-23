import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/is_login_bloc/is_login_bloc.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsLoginBloc, IsLoginState>(
      builder: (context, state) {
        bool isLogin = state.isLogin;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Еще нет аккаунта? ' : 'Уже есть аккаунт? ',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<IsLoginBloc>(context).add(IsLoginChangeEvent());
              },
              child: Text(
                isLogin ? 'Регистрация' : 'Войти',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
