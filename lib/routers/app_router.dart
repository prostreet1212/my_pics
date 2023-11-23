import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: RegCompleteRoute.page),
        AutoRoute(
            page: MainRoute.page,
            usesPathAsKey: true,
            initial: true,
            children: [
              AutoRoute(
                  page: NewslineRouter.page,
                  path: 'newsLineRouter',
                  usesPathAsKey: true,
                  children: [
                    AutoRoute(
                        page: NewsLineView.page,
                        path: 'newsLineView',
                        usesPathAsKey: true,
                        initial: true),
                    CustomRoute(
                        page: PostDetailView.page,
                        path: 'postDetailView',
                        usesPathAsKey: true,
                        transitionsBuilder: TransitionsBuilders.fadeIn),
                  ]),
              AutoRoute(
                page: NewPostView.page,
                path: 'newPostView',
                usesPathAsKey: true,
              ),
              AutoRoute(page: ProfileHeroRouter.page, initial: true, children: [
                CustomRoute(
                  page: ProfileView.page,
                  initial: true,
                ),
                CustomRoute(
                    page: ProfileSettingsView.page,
                    transitionsBuilder: _transitionsBuilder,
                    durationInMilliseconds: 500),
                CustomRoute(
                    page: PostDetailView.page,
                    transitionsBuilder: TransitionsBuilders.noTransition),
              ]),
            ]),
      ];
}

var _transitionsBuilder = (context, animation, secondaryAnimation, child) {
  Animatable<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero)
      .chain(CurveTween(curve: Curves.decelerate));
  Animatable<double> fade = Tween(begin: 0.5, end: 1);
  return SlideTransition(
    position: animation.drive(tween),
    child: FadeTransition(
      opacity: animation.drive(fade),
      child: child,
    ),
  );
};
