import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/add_activity/add_activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddActivityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddActivityBloc>(
      create: (context) => AddActivityBloc(),
      child: SizedBox(
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
                      child: AddActivity(),
                    )));
          },
          child: Text("Añadir Actividad", style: TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
