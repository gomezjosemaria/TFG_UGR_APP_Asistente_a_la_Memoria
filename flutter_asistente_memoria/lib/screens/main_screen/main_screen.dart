import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/role/role_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_asistente_memoria/screens/bond_care_receiver/bond_care_receiver.dart';
import 'package:flutter_asistente_memoria/screens/choose_role/choose_role.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/main_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleBloc()..add(RoleStarted()),
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (Authentication.getUserRole() == UserRole.unselected) {
          return ChooseRole();
        }
        else if (Authentication.getUserRole() == UserRole.caregiver) {
          if (Authentication.getUserBond() != '') {
            return BondCareReceiver();
          }
        }
        return MainMenu();
      },
    );
  }
}
