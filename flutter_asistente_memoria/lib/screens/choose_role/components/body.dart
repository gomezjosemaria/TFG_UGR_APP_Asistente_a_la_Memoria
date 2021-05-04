import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/choose_role/choose_role_bloc.dart';
import 'package:flutter_asistente_memoria/bloc/role/role_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            Text('Elige con que rol quieres registrate:'),
            _CareReceiverRoleButton(),
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
    return BlocBuilder<ChooseRoleBloc, ChooseRoleState>(
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
            child: Text("Cuidador"),
          ),
        );
      },
    );
  }
}

class _CareReceiverRoleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseRoleBloc, ChooseRoleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status == ChooseRoleStatus.caregiverSelectionProgress || state.status == ChooseRoleStatus.careReceiverSelectionProgress ? null : () {
              context.read<ChooseRoleBloc>().add(ChooseRoleCareReceiver());
            },
            child: Text("Cliente"),
          ),
        );
      },
    );
  }
}