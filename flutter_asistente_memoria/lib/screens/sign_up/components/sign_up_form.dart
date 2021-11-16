import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_asistente_memoria/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NameInput(),
        SizedBox(
          height: 20,
        ),
        _EmailInput(),
        SizedBox(
          height: 20,
        ),
        _PasswordInput(),
        SizedBox(
          height: 20,
        ),
        _SignUpButton(),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Nombre",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState> (
          buildWhen: (previous, current) => previous.nameInput != current.nameInput || current.formzStatus.isInvalid,
          builder: (context, state) {
            return TextField(
              key: const Key('signUpForm_nameInput_textField'),
              onChanged: (nameInput) => context.read<SignUpBloc>().add(SignUpNameInputChanged(nameInput)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                prefixIcon: Icon(
                  Icons.account_circle,
                ),
                hintText: "Introduce tu Nombre",
                errorText: state.nameInput.invalid || state.formzStatus.isInvalid && state.nameInput.pure ? "Nombre no válido" : null,
              ),
              style: TextStyle(fontSize: 20)
            );
          },
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState> (
          buildWhen: (previous, current) => previous.emailInput != current.emailInput || current.formzStatus.isInvalid,
          builder: (context, state) {
            return TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (emailInput) => context.read<SignUpBloc>().add(SignUpEmailInputChanged(emailInput)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Introduce tu Email",
                errorText: state.emailInput.invalid || state.formzStatus.isInvalid && state.emailInput.pure ? "Email no válido" : null,
              ),
              style: TextStyle(fontSize: 20)
            );
          },
        ),
      ],
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput>{

  bool _obscureText = true;

  void _toggleVisibility(){
    setState( () {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Contraseña",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState> (
          buildWhen: (previous, current) => previous.passwordInput != current.passwordInput || current.formzStatus.isInvalid,
          builder: (context, state) {
            return TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (passwordInput) => context.read<SignUpBloc>().add(SignUpPasswordInputChanged(passwordInput)),
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  onPressed: _toggleVisibility,
                ),
                hintText: "Introduce tu Contraseña",
                errorText: state.passwordInput.invalid || state.formzStatus.isInvalid && state.passwordInput.pure ? "Contraseña no válida" : null,
              ),
              style: TextStyle(fontSize: 20)
            );
          },
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.formzStatus != current.formzStatus,
      builder: (context, state) {
        if (state.formzStatus == FormzStatus.submissionSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationSingIn(Authentication.getCurrentUser()),
          );
          Navigator.pop(context);
        }
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.formzStatus.isSubmissionInProgress ? null : () {
              context.read<SignUpBloc>().add(const SignUpSubmitted());
            },
            child: state.formzStatus.isSubmissionInProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Registrarse", style: TextStyle(fontSize: 25)),
          ),
        );
      },

    );
  }
}