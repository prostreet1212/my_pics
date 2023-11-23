import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import '../../../../blocs/image_bloc/image_bloc.dart';
import '../../../../blocs/profile_text_fields_bloc/profile_text_fields_bloc.dart';

class CompleteWidget extends StatelessWidget {
  const CompleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
          return BlocBuilder<ProfileTextFieldsBloc, ProfileTextFieldsState>(
              builder: (context, textFieldState) {
            return GestureDetector(
              onTap: textFieldState.nameText == ''
                  ? null
                  : () {
                      BlocProvider.of<AuthBloc>(context).add(
                          CompleteRegistration(
                              name: textFieldState.nameText,
                              avatar: BlocProvider.of<ImageBloc>(context)
                                  .state
                                  .image));
                    },
              child: authState.completeStatus == AuthStatus.loading
                  ? SpinKitThreeInOut(
                      size: 21,
                      itemBuilder: (context, index) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        );
                      },
                    )
                  : Text(
                      'Завершить регистрацию',
                      style: TextStyle(
                          color: textFieldState.nameText == ''
                              ? const Color.fromARGB(255, 213, 212, 212)
                              : Colors.blue,
                          fontSize: 18),
                    ),
            );
          });
        }),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
      ],
    );
  }
}
