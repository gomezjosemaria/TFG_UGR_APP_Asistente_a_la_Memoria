
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditActivityDeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddActivityBloc, AddActivityState>(
      listenWhen: (previous, current) => current is ActivityDeleteSuccessState,
      listener: (context, state) {
        if (state is ActivityDeleteSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Activities()));
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is ActivityDeletingState ? null : () {
              context.read<AddActivityBloc>().add(AddActivityDelete());
            },
            child: state is ActivityDeletingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Eliminar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}