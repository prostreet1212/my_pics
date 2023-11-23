import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../../../blocs/newsline_bloc/newsline_bloc.dart';
import '../../../../../../../models/post.dart';

class NewsLineCard extends StatelessWidget {
  const NewsLineCard({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProfileAvatar(
                  post.avatar,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, s, progress) {
                    return Container(
                        color: Colors.transparent,
                        height: 10,
                        width: 10,
                        child: SpinKitRotatingCircle(
                          size: 40,
                          itemBuilder: (context, index) {
                            return const DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle),
                            );
                          },
                        ));
                  },
                  radius: 20,
                  backgroundColor: Colors.black26,
                  borderColor: Colors.transparent,
                  imageFit: BoxFit.fitHeight,
                  cacheImage: true,
                  showInitialTextAbovePicture: false,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  post.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.black26,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      post.timeAgo,
                      style: const TextStyle(color: Colors.black26),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 265,
            child: CachedNetworkImage(
              imageUrl: post.url,
              progressIndicatorBuilder: (context, url, progress) {
                return SpinKitFadingFour(
                    size: 100,
                    itemBuilder: (context, i) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.black12, shape: BoxShape.rectangle),
                      );
                    });
              },
              errorWidget: (context, url, error) {
                return const Center(
                  child: Text('Не удалось загрузить изображение'),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 8, left: 14, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(post.likes
                              .contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Icons.favorite
                          : Icons.favorite_outline_rounded),
                      color: Colors.redAccent,
                      onPressed: () {
                        BlocProvider.of<NewslineBloc>(context)
                            .add(ChangeLikeEvent(post: post));
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Нравится',
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      post.likes.isNotEmpty ? '${post.likes.length}' : '',
                      style: const TextStyle(color: Colors.redAccent),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(post.description, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
