import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/ui/screens/main_screen/views/newpost_view/widgets/add_post_button.dart';
import 'package:my_pics/ui/screens/main_screen/views/newpost_view/widgets/add_post_image.dart';
import 'package:my_pics/ui/screens/main_screen/views/newpost_view/widgets/name_post_text_field.dart';
import '../../../../../blocs/newpost_bloc/newpost_bloc.dart';
import '../widgets/nav_app_bar.dart';

@RoutePage()
class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewPostBloc>(
      create: (context) => NewPostBloc(),
      child: GestureDetector(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 56),
            child: const NavAppBar(
              title: 'Новый пост',
              isBack: false,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocConsumer<NewPostBloc, NewPostState>(
                  listener: (context, newPostState) {
                if (newPostState.postText != '' &&
                    newPostState.postFile != null &&
                    newPostState.postStatus == PostStatus.disable) {
                  BlocProvider.of<NewPostBloc>(context)
                      .add(ChangeStatusEvent(postStatus: PostStatus.enable));
                } else if ((newPostState.postText == '' ||
                        newPostState.postFile == null) &&
                    newPostState.postStatus == PostStatus.enable) {
                  BlocProvider.of<NewPostBloc>(context)
                      .add(ChangeStatusEvent(postStatus: PostStatus.disable));
                } else if (newPostState.postStatus == PostStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Не удалось загрузить пост. Проверьте интернет-соединение'),
                    ),
                  );
                }
              }, builder: (context, newPostState) {
                return Column(
                  children: [
                    AddPostImage(
                      newPostState: newPostState,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    newPostState.postStatus != PostStatus.tryagain
                        ? NamePostTextField(
                            textState: newPostState,
                          )
                        : const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                                'Пост опубликован, теперь он находится в разделах "лента" и "профиль"',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    AddPostButton(newPostState: newPostState),
                    const SizedBox(
                      height: 30,
                    ),
                    newPostState.postStatus == PostStatus.tryagain
                        ? TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              final tabsRouter = AutoTabsRouter.of(context);
                              tabsRouter.setActiveIndex(0);
                            },
                            child: const Text('Перейти в ленту'),
                          )
                        : const SizedBox(),
                  ],
                );
              }),
            ),
          ),
        ),
        onTap: () => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
