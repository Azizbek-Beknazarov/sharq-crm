import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/m_auth_bloc.dart';
import 'features/injection_container.dart' as di;

import 'features/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<AuthBloc>()..add(GetCurrentManagerEvent())),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todos',

          home: SplashScreen(),
          // home: ManagerPage(),
        ));
  }
}
