import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_settings_view/widgets/exit_widget.dart';
import 'package:my_pics/ui/screens/main_screen/views/profile_views/profile_settings_view/widgets/profile_form.dart';
import '../../widgets/nav_app_bar.dart';

@RoutePage()
class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56),
        child: const NavAppBar(
          title: 'Настройки профиля',
          isBack: true,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileForm(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.16,
                ),
                const ExitWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
