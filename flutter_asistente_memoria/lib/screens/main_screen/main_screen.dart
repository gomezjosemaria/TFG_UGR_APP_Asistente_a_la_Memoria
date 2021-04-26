import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/choose_role/choose_role_bloc.dart';
import 'package:flutter_asistente_memoria/screens/choose_role/choose_role.dart';
import 'package:flutter_asistente_memoria/screens/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseRoleBloc()..add(ChooseRoleStarted()),
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseRoleBloc, ChooseRoleState>(
      builder: (context, state) {
        if (state.status == ChooseRoleStatus.unselected) {
          return ChooseRole();
        }
        else {
          return Profile();
        }
      },
    );
  }
}