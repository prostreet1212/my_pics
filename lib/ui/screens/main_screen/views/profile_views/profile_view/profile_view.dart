import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_view/widgets/profile_info_widget.dart';
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_view/widgets/user_posts_grid_view.dart';
import '../../../../../../blocs/user_posts_bloc/user_posts_bloc.dart';
import '../../../../../../models/post.dart';
import '../../widgets/nav_app_bar.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPostsBloc>(
      create: (context) => UserPostsBloc()..add(GetUserPostsEvent()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 56),
          child: const NavAppBar(
            title: 'Профиль',
            appBarAction: AppBarAction.setting,
            isBack: false,
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: BlocProvider.of<AuthBloc>(context),
          listener: (context, authState) {},
          builder: (context, authState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        right: 8, left: 8, top: 30, bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileInfoWidget(authState: authState),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<UserPostsBloc, UserPostsState>(
                            builder: (context, userPostsState) {
                          UserPostsStatus status =
                              userPostsState.userPostsStatus;
                          List<Post> userPosts = userPostsState.userPosts;
                          switch (status) {
                            case UserPostsStatus.loading:
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: const SpinKitPouringHourGlass(
                                  color: Colors.blue,
                                  size: 100,
                                ),
                              );
                            case UserPostsStatus.failure:
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: const Center(
                                  child: Text(
                                    'Не удалось загрузить посты',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              );
                            case UserPostsStatus.success:
                              return UserPostsGridView(userPosts: userPosts);
                            default:
                              return Container();
                          }
                        })
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
