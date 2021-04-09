part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailInputChanged extends LoginEvent {
  final String emailInput;

  LoginEmailInputChanged(this.emailInput);

  @override
  List<Object> get props => [emailInput];
}

class LoginPasswordInputChanged extends LoginEvent {
  final String passwordInput;

  LoginPasswordInputChanged(this.passwordInput);

  @override
  List<Object> get props => [passwordInput];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}