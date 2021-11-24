import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity_last_step/edit_activity_last_step.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity_navigation_step/edit_activity_navigation_step.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNextStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
      builder: (context, state) {
        print('Editar');
        print(state.steps.length);
        print(state.stepInd);
        print(state.steps);
        print(state);
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
                        child: EditActivityLastStep())));
              },
              child: Text('Añadir Indicaciones', style: TextStyle(fontSize: 25)),
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
                        child: EditActivityLastStep())));
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
                        child: EditActivityNavigationStep(
                          next: true,
                        ))));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Siguiente Indicación', style: TextStyle(fontSize: 25)),
                  Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
