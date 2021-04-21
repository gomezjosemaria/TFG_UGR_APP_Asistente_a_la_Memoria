part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticationSingIn extends AuthenticationEvent {

  final UserModel user;

  const AuthenticationSingIn(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthenticationSingOut extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}