import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../../models/post.dart';
import '../../../../../../../routers/app_router.gr.dart';

class UserPostsGridView extends StatelessWidget {
  const UserPostsGridView({Key? key, required this.userPosts})
      : super(key: key);

  final List<Post> userPosts;

  @override
  Widget build(BuildContext context) {
    return userPosts.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: Text('Вы не добавили еще ни одного поста'),
            ),
          )
        : GridView.builder(
            itemCount: userPosts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                child: Ink(
                  child: Hero(
                    tag: 'postimage-${userPosts[index].postId}',
                    child: Card(
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        userPosts[index].url),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 2, left: 2),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    userPosts[index]
                                            .likes
                                            .contains(userPosts[index].uid)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 35,
                                  ),
                                  Text(
                                    userPosts[index].likes.isNotEmpty
                                        ? '${userPosts[index].likes.length}'
                                        : '',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                onTap: () {
                  AutoRouter.of(context).navigate(PostDetailView(
                      post: userPosts[index], titleAppBar: 'Профиль'));
                },
              );
            });
  }
}
