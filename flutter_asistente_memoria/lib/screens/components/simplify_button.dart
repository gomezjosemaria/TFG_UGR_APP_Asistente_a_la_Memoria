
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/profile/profile_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimplifyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status == ProfileStatus.simplifying ? null : () {
              bool s = !Authentication.getSimplify();
              context.read<ProfileBloc>().add(ProfileSimplify(s));
            },
            child: state.status == ProfileStatus.simplifying ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Authentication.getSimplify() == false ? Text("Simplificar Vista", style: TextStyle(fontSize: 25)) : Text("Vista Completa", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }

}