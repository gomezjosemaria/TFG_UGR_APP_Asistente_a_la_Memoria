import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/activities/activities_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity.dart';

class ActivitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == ActivitiesStatus.activitiesLoadedSuccessfully) {
          var list = <Widget>[];

          state.activities.forEach((i) {
            Activity activity = new Activity(activityModel: i);
            list.add(activity);
            list.add(new SizedBox(
              height: 10,
            ));
          });

          return Column(
            children: [
              Text("Actividades"),
              Column(
                children: list,
              ),
            ],
          );
        } else {
          return Text('Cargando actividades');
        }
      },
    );
  }
}
