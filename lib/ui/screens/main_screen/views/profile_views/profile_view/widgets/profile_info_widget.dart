import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import '../../../../../../../blocs/image_bloc/image_bloc.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key, required this.authState})
      : super(key: key);

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/avatar_star.png',
              scale: 1.8,
            ),
            const SizedBox(
              width: 5,
            ),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, imageState) {
                return CachedNetworkImage(
                  imageUrl: authState.user!.avatarUrl,
                  progressIndicatorBuilder: (context, url, progress) {
                    return CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 238, 234, 234),
                      radius: 48,
                      child: SpinKitFadingCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return const DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.black54, shape: BoxShape.circle),
                          );
                        },
                      ),
                    );
                  },
                  fit: BoxFit.fitHeight,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 96.0,
                    height: 96.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    if (authState.user!.avatarUrl == '') {
                      return const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 238, 234, 234),
                        radius: 48,
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      );
                    } else {
                      return const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 238, 234, 234),
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
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              'assets/images/avatar_star.png',
              scale: 1.8,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          authState.user?.name ?? 'Ошибка',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
