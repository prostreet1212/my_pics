// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/models/post.dart' as _i12;
import 'package:my_pics/routers/empty_route_page.dart' as _i1;
import 'package:my_pics/ui/screens/login_screen/login_screen.dart' as _i2;
import 'package:my_pics/ui/screens/main_screen/main_screen.dart' as _i3;
import 'package:my_pics/ui/screens/main_screen/views/newpost_view/newpost_view.dart'
    as _i4;
import 'package:my_pics/ui/screens/main_screen/views/newsline_view/newsline_view.dart'
    as _i5;
import 'package:my_pics/ui/screens/main_screen/views/post_detail_view/post_detail_view.dart'
    as _i6;
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_settings_view/profile_settings_view.dart'
    as _i7;
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_view/profile_view.dart'
    as _i8;
import 'package:my_pics/ui/screens/reg_complete_screen/reg_complete_screen.dart'
    as _i9;

import '../blocs/newsline_bloc/newsline_bloc.dart';

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    ProfileRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfileRouterPage(),
      );
    },
    NewslineRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
          routeData: routeData,
          child: BlocProvider<NewslineBloc>(
            create: (context) => NewslineBloc()..add(GetAllPostsEvent()),
            child: const _i1.NewslineRouterPage(),
          ));
    },
    ProfileHeroRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HeroEmptyRouterPage(),
      );
    },
    SplashRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MainScreen(),
      );
    },
    NewPostView.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NewPostView(),
      );
    },
    NewsLineView.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.NewsLineView(),
      );
    },
    PostDetailView.name: (routeData) {
      final args = routeData.argsAs<PostDetailViewArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PostDetailView(
          key: args.key,
          post: args.post,
          titleAppBar: args.titleAppBar,
        ),
      );
    },
    ProfileSettingsView.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileSettingsView(),
      );
    },
    ProfileView.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ProfileView(),
      );
    },
    RegCompleteRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.RegCompleteScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ProfileRouterPage]
class ProfileRouter extends _i10.PageRouteInfo<void> {
  const ProfileRouter({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRouter.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.NewslineRouterPage]
class NewslineRouter extends _i10.PageRouteInfo<void> {
  const NewslineRouter({List<_i10.PageRouteInfo>? children})
      : super(
          NewslineRouter.name,
          initialChildren: children,
        );

  static const String name = 'NewslineRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.HeroEmptyRouterPage]
class ProfileHeroRouter extends _i10.PageRouteInfo<void> {
  const ProfileHeroRouter({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileHeroRouter.name,
          initialChildren: children,
        );

  static const String name = 'ProfileHeroRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.SplashPage]
class SplashRouter extends _i10.PageRouteInfo<void> {
  const SplashRouter({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRouter.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.NewPostView]
class NewPostView extends _i10.PageRouteInfo<void> {
  const NewPostView({List<_i10.PageRouteInfo>? children})
      : super(
          NewPostView.name,
          initialChildren: children,
        );

  static const String name = 'NewPostView';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NewsLineView]
class NewsLineView extends _i10.PageRouteInfo<void> {
  const NewsLineView({List<_i10.PageRouteInfo>? children})
      : super(
          NewsLineView.name,
          initialChildren: children,
        );

  static const String name = 'NewsLineView';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PostDetailView]
class PostDetailView extends _i10.PageRouteInfo<PostDetailViewArgs> {
  PostDetailView({
    _i11.Key? key,
    required _i12.Post post,
    String titleAppBar = '',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PostDetailView.name,
          args: PostDetailViewArgs(
            key: key,
            post: post,
            titleAppBar: titleAppBar,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDetailView';

  static const _i10.PageInfo<PostDetailViewArgs> page =
      _i10.PageInfo<PostDetailViewArgs>(name);
}

class PostDetailViewArgs {
  const PostDetailViewArgs({
    this.key,
    required this.post,
    this.titleAppBar = '',
  });

  final _i11.Key? key;

  final _i12.Post post;

  final String titleAppBar;

  @override
  String toString() {
    return 'PostDetailViewArgs{key: $key, post: $post, titleAppBar: $titleAppBar}';
  }
}

/// generated route for
/// [_i7.ProfileSettingsView]
class ProfileSettingsView extends _i10.PageRouteInfo<void> {
  const ProfileSettingsView({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileSettingsView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileSettingsView';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ProfileView]
class ProfileView extends _i10.PageRouteInfo<void> {
  const ProfileView({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.RegCompleteScreen]
class RegCompleteRoute extends _i10.PageRouteInfo<void> {
  const RegCompleteRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegCompleteRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegCompleteRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
