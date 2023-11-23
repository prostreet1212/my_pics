import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../../models/post.dart';
import '../../../../../../../routers/app_router.gr.dart';
import 'newsline_card.dart';

class NewsLineList extends StatelessWidget {
  const NewsLineList({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? const Center(
            child: Text(
              'Лента пуста',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(
                      PostDetailView(post: posts[index], titleAppBar: 'Лента'));
                },
                child: Builder(builder: (context) {
                  if (kDebugMode) {
                    print('КАРТОЧКА ${posts[index].description}');
                  }
                  return NewsLineCard(post: posts[index]);
                }),
              );
            });
  }
}
