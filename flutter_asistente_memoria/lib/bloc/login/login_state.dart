part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.formzStatus = FormzStatus.pure,
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
  });

  final FormzStatus formzStatus;
  final EmailInput emailInput;
  final PasswordInput passwordInput;

  LoginState copyWith({
    FormzStatus? formzStatus,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
  }) {
    return LoginState(
      formzStatus: formzStatus ?? this.formzStatus,
      emailInput: emailInput ?? this.emailInput,
      passwordInput: passwordInput ?? this.passwordInput,
    );
  }

  @override
  List<Object> get props => [formzStatus, emailInput, passwordInput];
}

