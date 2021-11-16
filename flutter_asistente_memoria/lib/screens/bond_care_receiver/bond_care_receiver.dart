import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/bond_care_receiver_bloc/bond_care_receiver_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class BondCareReceiver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Recuerda Me', style: TextStyle(fontSize: 25)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => BondCareReceiverBloc(),
          child: Body(),
        ),
      ),
    );
  }
}