import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_pics/ui/screens/reg_complete_screen/widgets/complete_widget.dart';
import 'package:my_pics/ui/screens/reg_complete_screen/widgets/reg_form.dart';

@RoutePage()
class RegCompleteScreen extends StatelessWidget {
  const RegCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('regComplette screen build');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Заполнение профиля',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white12,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
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
                const RegForm(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.16,
                ),
                const CompleteWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
