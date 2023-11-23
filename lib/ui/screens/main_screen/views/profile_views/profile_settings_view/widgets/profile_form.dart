import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import '../../../../../../../blocs/image_bloc/image_bloc.dart';
import '../../../../../../../blocs/profile_text_fields_bloc/profile_text_fields_bloc.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageBloc, ImageState>(
      listener: (context, imageState) {
        if ((imageState.avatarStatus == AvatarStatus.failure)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(imageState.message),
            ),
          );
        } else if (imageState.avatarStatus == AvatarStatus.success &&
            imageState.message == 'Аватар изменен') {
          BlocProvider.of<AuthBloc>(context)
              .add(ChangeAvatarUrlEvent(imageState.avatarUrl));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(imageState.message),
            ),
          );
        }
      },
      builder: (context, imageState) {
        return BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (prev, next) {
            return (prev.forChanged != next.forChanged);
          },
          listener: (context, userState) {
            if (userState.message == 'Новое имя сохранено') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(userState.message),
                ),
              );
            }
          },
          builder: (context, userState) {
            BlocProvider.of<ProfileTextFieldsBloc>(context)
                .emailController
                .text = userState.user!.email;
            BlocProvider.of<ProfileTextFieldsBloc>(context)
                .nameController
                .text = userState.user!.name;
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
                              child: CachedNetworkImage(
                                //imageUrl: imageState.avatarUrl,
                                placeholder: (context, s) {
                                  return const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 238, 234, 234),
                                    radius: 48,
                                  );
                                },
                                imageUrl: imageState.avatarStatus ==
                                            AvatarStatus.fromMemory ||
                                        imageState.avatarStatus ==
                                            AvatarStatus.loading ||
                                        imageState.avatarStatus ==
                                            AvatarStatus.failure
                                    ? ''
                                    : imageState.avatarUrl == ''
                                        ? userState.user!.avatarUrl
                                        : imageState.avatarUrl,
                                fit: BoxFit.fitHeight,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 96.0,
                                  height: 96.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  if (imageState.avatarStatus ==
                                      AvatarStatus.loading) {
                                    return CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 238, 234, 234),
                                        radius: 48,
                                        backgroundImage: FileImage(
                                            imageState.image!,
                                            scale: 1.5),
                                        child: SpinKitFadingCircle(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  shape: BoxShape.circle),
                                            );
                                          },
                                        ));
                                  } else if (imageState.avatarStatus ==
                                          AvatarStatus.fromMemory ||
                                      imageState.image != null) {
                                    return CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 238, 234, 234),
                                        radius: 48,
                                        backgroundImage: FileImage(
                                            imageState.image!,
                                            scale: 1.5));
                                  } else if (userState.user!.avatarUrl == '') {
                                    return const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 238, 234, 234),
                                      radius: 48,
                                      child: Icon(
                                        Icons.person,
                                        size: 60,
                                      ),
                                    );
                                  } else {
                                    return const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 238, 234, 234),
                                      radius: 48,
                                      child: Icon(Icons.error),
                                    );
                                  }
                                },
                                errorListener: (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ImageBloc>(context).add(
                                    UploadAvatarEvent(
                                        avatar: imageState.image!));
                              },
                              child: const Text(
                                'Сменить фото профиля',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    TextField(
                      controller:
                          BlocProvider.of<ProfileTextFieldsBloc>(context)
                              .nameController,
                      cursorColor: const Color.fromARGB(255, 170, 193, 238),
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 170, 193, 238),
                          ),
                        ),
                        suffix: BlocProvider.of<ProfileTextFieldsBloc>(context)
                                .nameController
                                .text
                                .isNotEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 1,
                                    height: 23,
                                    color: const Color.fromARGB(
                                        255, 170, 193, 238),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      BlocProvider.of<AuthBloc>(context).add(
                                          UpdateNameUserEvent(
                                              uid: userState.user!.uid,
                                              newName: BlocProvider.of<
                                                          ProfileTextFieldsBloc>(
                                                      context)
                                                  .nameController
                                                  .text));
                                    },
                                    child: const Text(
                                      ' Сохранить',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        labelText: 'Ваше имя',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 170, 193, 238)),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 170, 193, 238)),
                        ),
                      ),
                      onChanged: (newText) {
                        BlocProvider.of<ProfileTextFieldsBloc>(context)
                            .add(ChangeProfileNameEvent(newText: newText));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller:
                          BlocProvider.of<ProfileTextFieldsBloc>(context)
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
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 193, 238)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 170, 193, 238)),
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
      },
    );
  }
}
