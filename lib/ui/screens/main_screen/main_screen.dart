import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/routers/app_router.gr.dart' as router;

import '../../../blocs/nav_bar_bloc/nav_bar_bloc.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('main screen build');
    }
    return BlocProvider<NavBarBloc>(
      create: (context) => NavBarBloc(),
      child: AutoTabsRouter.pageView(
          routes: const [
            router.NewsLineView(),
            router.NewPostView(),
            router.ProfileView(),
          ],
          builder: (context, child, _) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.photo), label: 'Лента'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline_outlined),
                      label: 'Новый пост'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Профиль'),
                ],
              ),
            );
          }),
    );
  }
}
