part of 'authentication_bloc.dart';

enum AuthenticationStatus {authenticated, unauthenticated}

class AuthenticationState extends Equatable {

  final AuthenticationStatus authenticationStatus;
  final UserModel user;

  const AuthenticationState({
    this.authenticationStatus = AuthenticationStatus.unauthenticated,
    this.user = UserModel.empty,
  });

  AuthenticationState authenticated(UserModel user) {
    return AuthenticationState(
      authenticationStatus: AuthenticationStatus.authenticated,
      user: user,
    );
  }

  AuthenticationState unauthenticated() {
    return AuthenticationState(
      authenticationStatus: AuthenticationStatus.unauthenticated,
      user: UserModel.empty,
    );
  }

  @override
  List<Object?> get props => [authenticationStatus, user];
}
