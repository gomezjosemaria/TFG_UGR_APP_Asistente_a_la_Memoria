import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/choose_role/choose_role_bloc.dart';
import 'package:flutter_asistente_memoria/screens/choose_role/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Recuerda Me', style: TextStyle(fontSize: 25)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => ChooseRoleBloc(),
          child: Body(),
        ),
      ),
    );
  }
}
