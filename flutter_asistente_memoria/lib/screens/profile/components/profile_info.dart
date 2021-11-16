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
        SizedBox(
          height: 25,
        ),
        UserRoleInfo(userRole: userRole),
        SizedBox(
          height: 25,
        ),
        Photo(),
        SizedBox(
          height: 25,
        ),
        Text(user.email, style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 25,
        ),
        if (userRole == UserRole.careReceiver)
          Text("Código de vinculación: " + Authentication.getUserBondCode(), style: TextStyle(fontSize: 20)),
        /*if (userRole == UserRole.careReceiver)
          Text("Usuario vinculado: " + Authentication.getUserBonds().toString()),*/
      ],
    );
  }
}

class UserRoleInfo extends StatelessWidget {
  final UserRole userRole;

  const UserRoleInfo({Key? key, required this.userRole}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (userRole == UserRole.careReceiver) {
      return Text('Persona', style: TextStyle(fontSize: 35));
    }
    else {
      return Text('Cuidador', style: TextStyle(fontSize: 35));
    }
  }
}

class Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return CircleAvatar(
      backgroundImage: AssetImage('assets/fake_profile.png'),
      backgroundColor: Colors.white,
      radius: 75,
    );*/
    return Icon(
      Icons.account_circle,
      size: 200,
    );
  }
}

