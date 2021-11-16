import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/add_activity/add_activity.dart';
import 'package:flutter_asistente_memoria/screens/add_activity_navigation_step/add_activity_navigation_step.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousStepButton extends StatelessWidget {
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
                        child: AddActivity())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_left,
                    size: 50,
                  ),
                  Text('Anterior Indicación', style: TextStyle(fontSize: 25)),
                ],
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
                        child: AddActivityNavigationStep(
                          next: false,
                        ))));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_left,
                    size: 50,
                  ),
                  Text('Anterior Indicación', style: TextStyle(fontSize: 25)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
