import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_asistente_memoria/bloc/login/login_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmailInput(),
        SizedBox(
          height: 20,
        ),
        _PasswordInput(),
        SizedBox(
          height: 20,
        ),
        _LoginButton(),
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
        BlocBuilder<LoginBloc, LoginState> (
          buildWhen: (previous, current) => previous.emailInput != current.emailInput || current.formzStatus.isInvalid,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (emailInput) => context.read<LoginBloc>().add(LoginEmailInputChanged(emailInput)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Introduce tu Email",
                hintStyle: TextStyle(color: Color(0xff646464)),
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
        BlocBuilder<LoginBloc, LoginState> (
          buildWhen: (previous, current) => previous.passwordInput != current.passwordInput || current.formzStatus.isInvalid,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (passwordInput) => context.read<LoginBloc>().add(LoginPasswordInputChanged(passwordInput)),
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.formzStatus != current.formzStatus,
      builder: (context, state) {
        if (state.formzStatus.isSubmissionSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationSingIn(Authentication.getCurrentUser()),
          );
        }
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.formzStatus.isSubmissionInProgress ? null : () {
              context.read<LoginBloc>().add(const LoginSubmitted());
            },
            child: state.formzStatus.isSubmissionInProgress ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text("Iniciar Sesión", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}