part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.formzStatus = FormzStatus.pure,
    this.nameInput = const NameInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
  });

  final FormzStatus formzStatus;
  final NameInput nameInput;
  final EmailInput emailInput;
  final PasswordInput passwordInput;

  SignUpState copyWith({
    FormzStatus? formzStatus,
    NameInput? nameInput,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
  }) {
    return SignUpState(
      formzStatus: formzStatus ?? this.formzStatus,
      nameInput: nameInput ?? this.nameInput,
      emailInput: emailInput ?? this.emailInput,
      passwordInput: passwordInput ?? this.passwordInput,
    );
  }

  @override
  List<Object> get props => [formzStatus, nameInput, emailInput, passwordInput];
}
