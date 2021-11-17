import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/profile/profile_bloc.dart';
import 'package:flutter_asistente_memoria/screens/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => current.status == ProfileStatus.log_out,
      listener: (context, state) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status == ProfileStatus.login_out ? null : () {
              context.read<ProfileBloc>().add(const ProfileLogOut());
            },
            child: state.status == ProfileStatus.login_out ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) :Text("Cerrar Sesión", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }

}