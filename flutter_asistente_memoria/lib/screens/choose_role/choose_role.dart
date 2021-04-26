import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/choose_role/choose_role_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => ChooseRoleBloc(),
          child: Align(
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
          ),
        ),
      ),
    );
  }
}

class _CaregiverRoleButton extends StatelessWidget {
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
        },
        child: Text("Cuidador"),
      ),
    );
  }
}

class _CareReceiverRoleButton extends StatelessWidget {
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
        },
        child: Text("Cuidado"),
      ),
    );
  }
}
