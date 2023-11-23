import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../blocs/post_detail_bloc/post_detail_bloc.dart';
import '../../../../../../models/post.dart';
import '../../widgets/nav_app_bar.dart';

class PostDetailAppBar extends StatelessWidget {
  const PostDetailAppBar({Key? key, required this.titleAppBar})
      : super(key: key);
  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostDetailBloc, PostDetailState>(
      listener: (context, state) {
        Post emptyPost = const Post();
        if (state.deleteStatus == DeleteStatus.initial &&
            state.selectedPost == emptyPost) {
        } else if (state.deleteStatus == DeleteStatus.complete &&
            state.selectedPost == emptyPost) {
          AutoRouter.of(context).pop().whenComplete(() {
            AutoRouter.of(context).pop().whenComplete(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Пост удален'),
                duration: Duration(seconds: 3),
              ));
            });
          });
        }
      },
      builder: (context, state) {
        return NavAppBar(
          title: titleAppBar,
          isBack: true,
          appBarAction:
              FirebaseAuth.instance.currentUser!.uid == state.selectedPost.uid
                  ? AppBarAction.deletePost
                  : AppBarAction.empty,
        );
      },
    );
  }
}
