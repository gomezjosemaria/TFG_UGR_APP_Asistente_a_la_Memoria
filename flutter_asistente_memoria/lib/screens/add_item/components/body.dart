import 'package:flutter/material.dart';

import 'add_item_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddItemForm(),
          ],
        ),
      ),
    );
  }
}