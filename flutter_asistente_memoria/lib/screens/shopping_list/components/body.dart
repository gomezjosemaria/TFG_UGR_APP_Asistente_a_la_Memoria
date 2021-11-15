import 'package:flutter/material.dart';

import 'add_item_button.dart';
import 'item_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddItemButton(),
            ItemList(),
          ],
        ),
      ),
    );
  }
}