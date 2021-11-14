import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity/edit_activity.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity_navigation_step/edit_activity_navigation_step.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPreviousStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
      buildWhen: (previous, current) => previous.stepInd != current.stepInd,
      builder: (context, state) {
        if (state.stepInd - 1 == 0) {
          return SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AddActivityBloc>(context),
                        child: EditActivity())));
              },
              child: Icon(
                Icons.arrow_left,
                size: 50,
              ),
            ),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AddActivityBloc>(context),
                        child: EditActivityNavigationStep(
                          next: false,
                        ))));
              },
              child: Icon(
                Icons.arrow_left,
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}
