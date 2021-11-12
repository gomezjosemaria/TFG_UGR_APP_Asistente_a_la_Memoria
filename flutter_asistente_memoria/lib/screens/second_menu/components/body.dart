import 'package:flutter/material.dart';
import 'button_grid.dart';
import 'previous_menu_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            ButtonGrid(),
            SizedBox(height: 20),
            PreviousMenuButton(),
          ],
        ),
      ),
    );
  }
}