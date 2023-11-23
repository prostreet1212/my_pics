import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/ui/screens/main_screen/views/post_detail_view/widgets/like_user_panel.dart';
import 'package:my_pics/ui/screens/main_screen/views/post_detail_view/widgets/post_detail_app_bar.dart';
import 'package:my_pics/ui/screens/main_screen/views/post_detail_view/widgets/post_info_widget.dart';
import 'package:my_pics/ui/screens/main_screen/views/post_detail_view/widgets/user_info_panel.dart';
import '../../../../../../models/post.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../blocs/post_detail_bloc/post_detail_bloc.dart';

@RoutePage()
class PostDetailView extends StatelessWidget {
  const PostDetailView({Key? key, required this.post, this.titleAppBar = ''})
      : super(key: key);
  final Post post;
  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostDetailBloc>(
      create: (context) => PostDetailBloc(post)..add(GetSelectedPostEvent()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 56),
          child: PostDetailAppBar(
            titleAppBar: titleAppBar,
          ),
        ),
        body: BlocBuilder<PostDetailBloc, PostDetailState>(
            buildWhen: (prev, next) => prev.selectedPost != next.selectedPost,
            builder: (context, state) {
              Post post = state.selectedPost;
              if (kDebugMode) {
                print('ДЕТАЛЬ');
              }
              Post emptyPost = const Post();
              return (state.selectedPost == emptyPost)
                  ? Container()
                  : ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UserInfoPanel(
                              post: post,
                            ),
                            Container(
                              height: 1,
                              color: Colors.black12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PostInfoWidget(post: post),
                            Container(
                              height: 1,
                              color: Colors.black12,
                            ),
                            LikeUserPanel(post: post)
                          ],
                        ),
                      ),
                    );
            }),

        //),
      ),
    );
  }
}
