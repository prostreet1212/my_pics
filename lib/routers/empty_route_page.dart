import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'ProfileRouter')
class ProfileRouterPage extends StatelessWidget {
  const ProfileRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage(name: 'NewslineRouter')
class NewslineRouterPage extends StatelessWidget {
  const NewslineRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage(name: 'ProfileHeroRouter')
class HeroEmptyRouterPage extends StatelessWidget {
  const HeroEmptyRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: HeroController(),
      child: const AutoRouter(),
    );
  }
}

@RoutePage(name: 'SplashRouter')
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
