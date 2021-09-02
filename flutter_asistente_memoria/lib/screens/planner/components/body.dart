import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/planner/components/planner_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: PlannerList(),
      ),
    );
  }
}
