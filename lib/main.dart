import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/image_bloc/image_bloc.dart';
import 'blocs/profile_text_fields_bloc/profile_text_fields_bloc.dart';
import 'routers/app_router.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'firebase_options.dart';

final _appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..add(CheckUserEvent())),
        BlocProvider<ProfileTextFieldsBloc>(
            create: (context) => ProfileTextFieldsBloc()),
        BlocProvider(
          create: (context) => ImageBloc()
            ..add(CheckAndDownloadImageEvent(
                uid: BlocProvider.of<AuthBloc>(context).state.user!.uid,
                url: BlocProvider.of<AuthBloc>(context).state.user!.avatarUrl)),
        )
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'SfUiDisplay',
          primarySwatch: Colors.blue,
        ),
        //home:  LoginScreen(),
      ),
    );
  }
}
