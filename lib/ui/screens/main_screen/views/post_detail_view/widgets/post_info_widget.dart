import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../blocs/post_detail_bloc/post_detail_bloc.dart';
import '../../../../../../models/post.dart';

class PostInfoWidget extends StatelessWidget {
  const PostInfoWidget({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 295,
          child: Center(
            child: Hero(
              tag: 'postimage-${post.postId}',
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
                  return const Text('Не удалось загрузить изображение');
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 1,
          color: Colors.black12,
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 26, left: 26, top: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    onPressed: () async {
                      BlocProvider.of<PostDetailBloc>(context)
                          .add(ChangeLikeDetailPostEvent(post: post));
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
    );
  }
}
