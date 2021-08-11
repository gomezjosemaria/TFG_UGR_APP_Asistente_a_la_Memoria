import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/bond_care_receiver_bloc/bond_care_receiver_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/screens/components/log_out_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Bienvenido ' + Authentication.getCurrentUser().name + ','),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Al registrarse como Cuidador es necesario vincular su cuenta con un Cliente:'),
            ),
            SizedBox(
              height: 10,
            ),
            _CareReceiverEmailInput(),
            SizedBox(
              height: 10,
            ),
            _CareReceiverCodeInput(),
            SizedBox(
              height: 20,
            ),
            _BondButton(),
            SizedBox(
              height: 60,
            ),
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _BondButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BondCareReceiverBloc, BondCareReceiverState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress ? null : () {
              context.read<BondCareReceiverBloc>().add(const BondCareReceiverSubmitted());
            },
            child: state.status.isSubmissionInProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Vincular"),
          ),
        );
      },
    );
  }
}

class _CareReceiverCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Código de vinculación del Cliente",
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<BondCareReceiverBloc, BondCareReceiverState>(
          buildWhen: (previous, current) => previous.codeInput != current.codeInput,
          builder: (context, state) {
            return TextField(
              key: const Key('body_careReceiverCodeInput_textField'),
              onChanged: (codeInput) => context.read<BondCareReceiverBloc>().add(BondCareReceiverCodeInputChanged(codeInput)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Introduce el código de vinculación",
              ),
            );
          }
        ),
      ],
    );
  }
}

class _CareReceiverEmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email del Cliente",
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<BondCareReceiverBloc, BondCareReceiverState>(
          buildWhen: (previous, current) => previous.emailInput != current.emailInput,
          builder: (context, state) {
           return TextField(
             key: const Key('body_careReceiverEmailInput_textField'),
             onChanged: (emailInput) => context.read<BondCareReceiverBloc>().add(BondCareReceiverEmailInputChanged(emailInput)),
             decoration: InputDecoration(
               border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(100)
               ),
               prefixIcon: Icon(
                 Icons.email,
               ),
               hintText: "Introduce el Email del Cliente",
             ),
           );
          }
        ),
      ],
    );
  }
}
