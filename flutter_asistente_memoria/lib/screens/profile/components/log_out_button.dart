import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/screens/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Authentication.singOut();
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationSingOut(),
          );
        },
        child: Text("Cerrar Sesión"),
      ),
    );
  }

}