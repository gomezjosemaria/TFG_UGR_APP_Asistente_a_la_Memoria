part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();
}

class RoleStarted extends RoleEvent {
  @override
  List<Object?> get props => [];
}

class RoleSelection extends RoleEvent {
  @override
  List<Object?> get props => [];
}

class RoleCaregiver extends RoleEvent {
  @override
  List<Object?> get props => [];
}

class RoleCareReceiver extends RoleEvent {
  @override
  List<Object?> get props => [];
}