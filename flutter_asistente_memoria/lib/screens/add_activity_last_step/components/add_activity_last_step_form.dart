import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_asistente_memoria/screens/add_activity/components/add_activity_step_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddActivityLastStepForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddActivityStepInput(),
        SizedBox(
          width: double.infinity,
          height: 20.0,
        ),
        _AddActivityButton(),
      ],
    );
  }
}

class _AddActivityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddActivityBloc, AddActivityState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Activities()));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
                    context
                        .read<AddActivityBloc>()
                        .add(const AddActivitySubmitted());
                  },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}
