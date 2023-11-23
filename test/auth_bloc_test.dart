

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_pics/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


Future<void> main()async{
   AuthBloc? authBloc;
  
  setUp(() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
   authBloc=AuthBloc();
  });

   tearDown(() {
     authBloc!.close();
   });





}