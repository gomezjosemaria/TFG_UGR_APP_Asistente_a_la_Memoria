import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_asistente_memoria/screens/login/login.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/main_menu.dart';
import 'package:flutter_asistente_memoria/screens/main_screen/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppView();
  }
}

class MyAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente Memoria',
      theme: ThemeData(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.authenticationStatus ==
              AuthenticationStatus.authenticated) {
            return MainScreen();
          } else {
            return MainMenu();
          }
        },
      ),
    );
  }
}
