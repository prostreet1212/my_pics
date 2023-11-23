import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_pics/routers/app_router.gr.dart';

import '../../../../../../../blocs/image_bloc/image_bloc.dart';
import '../../../../../../../blocs/profile_text_fields_bloc/profile_text_fields_bloc.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              BlocProvider.of<AuthBloc>(context).add(ClearUserEvent());
              BlocProvider.of<ImageBloc>(context).add(ClearImageEvent());
              BlocProvider.of<ProfileTextFieldsBloc>(context)
                  .add(ClearTextFieldsEvent());
              AutoRouter.of(context).replace(const LoginRoute());
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Не удалось выйти из аккаунта'),
                ),
              );
            });
          },
          child: const Text(
            'Выйти из аккаунта',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
      ],
    );
  }
}
