import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Photo(),
        SizedBox(
          height: 10,
        ),
        Name(),
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

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Mi nombre');
  }
}

