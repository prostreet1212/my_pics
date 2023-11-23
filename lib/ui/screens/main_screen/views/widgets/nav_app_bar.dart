import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/ui/screens/main_screen/views/widgets/delete_post_dialog.dart';
import '../../../../../blocs/post_detail_bloc/post_detail_bloc.dart';
import '../../../../../models/post.dart';
import '../../../../../routers/app_router.gr.dart';

enum AppBarAction { empty, setting, deletePost }

class NavAppBar extends StatelessWidget {
  const NavAppBar(
      {Key? key,
      required this.title,
      this.appBarAction = AppBarAction.empty,
      required this.isBack})
      : super(key: key);
  final String title;
  final AppBarAction appBarAction;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
              ),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            )
          : const SizedBox(),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white12,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(color: Colors.black12, height: 1.0),
      ),
      actions: appBarAction == AppBarAction.setting
          ? [
              IconButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const ProfileSettingsView());
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.blueAccent,
                  ))
            ]
          : appBarAction == AppBarAction.deletePost
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (innerContext) {
                            return BlocProvider.value(
                              value: context.watch<PostDetailBloc>(),
                              child:
                                  BlocConsumer<PostDetailBloc, PostDetailState>(
                                listener: (context, state) {
                                  Post emptyPost = const Post();
                                  if (state.deleteStatus ==
                                          DeleteStatus.complete &&
                                      state.selectedPost == emptyPost) {}
                                },
                                builder: (context, state) {
                                  return const DeletePostDialog();
                                },
                              ),
                            );
                          });
                    },
                  ),
                ]
              : [],
    );
  }
}
