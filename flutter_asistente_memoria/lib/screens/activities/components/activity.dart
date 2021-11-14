import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/model/activity_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity/edit_activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key, required this.activityModel}) : super(key: key);

  final ActivityModel activityModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddActivityBloc>(
      create: (context) => AddActivityBloc(),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<AddActivityBloc>(context)
                        ..add(AddActivityStarted(activityModel)),
                      child: EditActivity(),
                    )));
          },
          child: Container(
            child: Column(
              children: [
                Text(activityModel.tittle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
