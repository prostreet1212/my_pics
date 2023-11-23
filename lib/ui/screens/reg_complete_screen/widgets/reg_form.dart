import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_pics/routers/app_router.gr.dart';
import '../../../../blocs/image_bloc/image_bloc.dart';
import '../../../../blocs/profile_text_fields_bloc/profile_text_fields_bloc.dart';

class RegForm extends StatelessWidget {
  const RegForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, userState) {
        if ((userState.completeStatus == AuthStatus.success)) {
          AutoRouter.of(context).replaceAll([const MainRoute()]);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userState.message),
              duration: const Duration(seconds: 5),
            ),
          );
        } else if (userState.completeStatus == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userState.message),
            ),
          );
        }
      },
      builder: (context, userState) {
        BlocProvider.of<ProfileTextFieldsBloc>(context).emailController.text =
            userState.user!.email;

        return BlocBuilder<ProfileTextFieldsBloc, ProfileTextFieldsState>(
            builder: (context, textFieldState) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Column(
              children: [
                BlocConsumer<ImageBloc, ImageState>(
                  listener: (context, imageState) {},
                  builder: (context, imageState) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ImageBloc>(context)
                                .add(GetImageFromMemoryEvent());
                          },
                          child: BlocBuilder<ImageBloc, ImageState>(
                            builder: (context, imageState) {
                              return CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 238, 234, 234),
                                radius: 50,
                                backgroundImage: imageState.image != null
                                    ? FileImage(imageState.image!, scale: 1.5)
                                    : null,
                                child: imageState.avatarStatus ==
                                        AvatarStatus.loading
                                    ? SpinKitFadingCircle(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.black54,
                                                shape: BoxShape.circle),
                                          );
                                        },
                                      )
                                    : imageState.image == null
                                        ? Image.asset(
                                            'assets/images/reg_avatar.png',
                                            scale: 1.2,
                                          )
                                        : null,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 46, //36
                ),
                TextField(
                  controller: BlocProvider.of<ProfileTextFieldsBloc>(context)
                      .nameController,
                  cursorColor: const Color.fromARGB(255, 170, 193, 238),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 170, 193, 238),
                      ),
                    ),
                    labelText: 'Введите имя',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 170, 193, 238)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 170, 193, 238)),
                    ),
                  ),
                  onChanged: (newText) async {
                    BlocProvider.of<ProfileTextFieldsBloc>(context)
                        .add(ChangeProfileNameEvent(newText: newText));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: BlocProvider.of<ProfileTextFieldsBloc>(context)
                      .emailController,
                  enabled: false,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 176, 176, 176)),
                  cursorColor: const Color.fromARGB(255, 170, 193, 238),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 170, 193, 238),
                      ),
                    ),
                    labelText: 'E-mail',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 170, 193, 238)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 170, 193, 238)),
                    ),
                    suffixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromARGB(255, 170, 193, 238),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
