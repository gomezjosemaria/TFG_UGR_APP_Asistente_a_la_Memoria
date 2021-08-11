import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Authentication.getCurrentUser();
    final UserRole userRole = Authentication.getUserRole();
    return Column(
      children: [
        Text(userRole.toString()),
        Photo(),
        SizedBox(
          height: 10,
        ),
        Text(user.name),
        if (userRole == UserRole.careReceiver)
          Text("Código de vinculación: " + Authentication.getUserBondCode()),
        if (userRole == UserRole.careReceiver)
          Text("Usuario vinculado: " + Authentication.getUserBonds().toString()),
      ],
    );
  }
}

class Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/fake_profile.png'),
      backgroundColor: Colors.white,
      radius: 75,
    );
  }
}

