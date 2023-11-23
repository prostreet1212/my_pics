import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/ui/screens/main_screen/views/newsline_view/widgets/newsline_list.dart';
import 'package:my_pics/ui/screens/main_screen/views/widgets/nav_app_bar.dart';
import '../../../../../../blocs/newsline_bloc/newsline_bloc.dart';
import '../../../../../../models/post.dart';

@RoutePage()
class NewsLineView extends StatelessWidget {
  const NewsLineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56),
        child: const NavAppBar(
          title: 'Лента',
          isBack: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<NewslineBloc, NewslineState>(
          builder: (context, allPostsState) {
            switch (allPostsState.allPostsStatus) {
              case AllPostsStatus.loading:
                return const Center(
                  child: SpinKitPouringHourGlass(
                    color: Colors.blue,
                    size: 100,
                  ),
                );
              case AllPostsStatus.failure:
                return const Center(
                  child: Text(
                    'Не удалось загрузить посты',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              case AllPostsStatus.success:
                List<Post> posts = allPostsState.allPosts;
                return NewsLineList(posts: posts);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
