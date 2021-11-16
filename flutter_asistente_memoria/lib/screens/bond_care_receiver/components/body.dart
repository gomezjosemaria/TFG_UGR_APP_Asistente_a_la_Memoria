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
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Al registrarse como Cuidador es necesario vincular su cuenta con una Pesona, para ello introduzca el Email y el Código de Vinculación de la Persona con la que desea vincularse:', style: TextStyle(fontSize: 25)),
            ),
            SizedBox(
              height: 20,
            ),
            _CareReceiverEmailInput(),
            SizedBox(
              height: 20,
            ),
            _CareReceiverCodeInput(),
            SizedBox(
              height: 30,
            ),
            _BondButton(),
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
            child: state.status.isSubmissionInProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Vincular", style: TextStyle(fontSize: 25)),
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
            "Código de Vinculación de la Persona",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
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
                  Icons.vpn_key,
                ),
                hintText: "Introduce el Código de Vinculación",
              ),
              style: TextStyle(fontSize: 20)
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
            "Email de la Persona",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
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
               hintText: "Introduce el Email",
             ),
             style: TextStyle(fontSize: 20)
           );
          }
        ),
      ],
    );
  }
}
