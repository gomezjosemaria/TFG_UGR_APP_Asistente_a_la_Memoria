import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/choose_role/choose_role_bloc.dart';
import 'package:flutter_asistente_memoria/bloc/role/role_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_asistente_memoria/screens/bond_care_receiver/bond_care_receiver.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/main_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Hola ' + Authentication.getCurrentUser().name + ',', style: TextStyle(fontSize: 23)),
            ),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            Text('Para usar la aplicación es necesario seleccionar el rol de usuario.', style: TextStyle(fontSize: 23)),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            Text('Selecciona el rol de Persona si quieres recibir notificaciones y recordatorios de la aplicación:', style: TextStyle(fontSize: 23)),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            _CareReceiverRoleButton(),
            SizedBox(
              width: double.infinity,
              height: 200.0,
            ),
            Text('Selecciona el rol de Cuidador si quieres vincularte a un usuario con el rol de Persona para añadirle alarmas y recordatorios pero tú no los recibirás:', style: TextStyle(fontSize: 23)),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            _CaregiverRoleButton(),
          ],
        ),
      ),
    );
  }
}

class _CaregiverRoleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseRoleBloc, ChooseRoleState>(
      listenWhen: (previous, current) => current.status == ChooseRoleStatus.selectionSuccess,
      listener: (context, state) {
        if (Authentication.getUserRole() == UserRole.careReceiver) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu()));
        }
        else if (Authentication.getUserRole() == UserRole.caregiver) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BondCareReceiver()));

        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == ChooseRoleStatus.selectionSuccess) {
          UserRole userRole = Authentication.getUserRole();
          if (userRole == UserRole.caregiver) {
            BlocProvider.of<RoleBloc>(context).add(
                RoleCaregiver(),
            );
          }
          else if (userRole == UserRole.careReceiver) {
            BlocProvider.of<RoleBloc>(context).add(
              RoleCareReceiver(),
            );
          }
        }
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status == ChooseRoleStatus.caregiverSelectionProgress || state.status == ChooseRoleStatus.careReceiverSelectionProgress ? null : () {
              context.read<ChooseRoleBloc>().add(ChooseRoleCaregiver());
            },
            child: state.status == ChooseRoleStatus.caregiverSelectionProgress || state.status == ChooseRoleStatus.careReceiverSelectionProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Cuidador", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}

class _CareReceiverRoleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseRoleBloc, ChooseRoleState>(
      listenWhen: (previous, current) => current.status == ChooseRoleStatus.selectionSuccess,
      listener: (context, state) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BondCareReceiver()));
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 120.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status == ChooseRoleStatus.caregiverSelectionProgress || state.status == ChooseRoleStatus.careReceiverSelectionProgress ? null : () {
              context.read<ChooseRoleBloc>().add(ChooseRoleCareReceiver());
            },
            child: state.status == ChooseRoleStatus.caregiverSelectionProgress || state.status == ChooseRoleStatus.careReceiverSelectionProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Persona", style: TextStyle(fontSize: 50)),
          ),
        );
      },
    );
  }
}