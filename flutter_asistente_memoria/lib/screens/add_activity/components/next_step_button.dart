import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/add_activity_last_step/add_activity_last_step.dart';
import 'package:flutter_asistente_memoria/screens/add_activity_navigation_step/add_activity_navigation_step.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
      buildWhen: (previous, current) => previous.stepInd != current.stepInd,
      builder: (context, state) {
        if (state.steps.length - 1 == state.stepInd) {
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
                        child: AddActivityLastStep())));
              },
              child: Text('Añadir Indicaciones'),
            ),
          );
        } else if (state.stepInd + 1 == state.steps.length) {
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
                        child: AddActivityLastStep())));
              },
              child: Icon(
                Icons.arrow_right,
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
                        child: AddActivityNavigationStep(
                          next: true,
                        ))));
              },
              child: Icon(
                Icons.arrow_right,
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}
