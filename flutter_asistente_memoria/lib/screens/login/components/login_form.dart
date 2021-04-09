import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmailInput(),
        SizedBox(
          height: 10,
        ),
        _PasswordInput(),
        SizedBox(
          height: 100,
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
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<LoginBloc, LoginState> (
          buildWhen: (previous, current) => previous.emailInput != current.emailInput,
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
                errorText: state.emailInput.invalid ? "Email no válido" : null,
              ),
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
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<LoginBloc, LoginState> (
          buildWhen: (previous, current) => previous.passwordInput != current.passwordInput,
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
                errorText: state.passwordInput.invalid ? "Contraseña no válida" : null,
              ),
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
    return SizedBox(
        width: double.infinity,
        height: 60.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder()
            ),
            onPressed: null,
            child: Text("Iniciar Sesión")
        )
    );
  }
}