import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/login/login_bloc.dart';
import 'package:flutter_asistente_memoria/screens/login/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: Body(),
        ),
      ),
    );
  }
}