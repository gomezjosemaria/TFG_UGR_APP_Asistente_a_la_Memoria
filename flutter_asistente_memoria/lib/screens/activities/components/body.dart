import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activities_list.dart';
import 'add_activity_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddActivityBloc(),
      child: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Column(
            children: [
              BlocProvider(
                create: (context) => AddActivityBloc(),
                child: AddActivityButton(),
              ),
              ActivitiesList(),
            ],
          ),
        ),
      ),
    );
  }
}
