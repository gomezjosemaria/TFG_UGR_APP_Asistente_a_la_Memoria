part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpNameInputChanged extends SignUpEvent {
  final String nameInput;

  SignUpNameInputChanged(this.nameInput);

  @override
  List<Object?> get props => [nameInput];
}

class SignUpEmailInputChanged extends SignUpEvent {
  final String emailInput;

  SignUpEmailInputChanged(this.emailInput);

  @override
  List<Object> get props => [emailInput];
}

class SignUpPasswordInputChanged extends SignUpEvent {
  final String passwordInput;

  SignUpPasswordInputChanged(this.passwordInput);

  @override
  List<Object> get props => [passwordInput];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();

  @override
  List<Object> get props => [];
}
