part of 'choose_role_bloc.dart';

abstract class ChooseRoleEvent extends Equatable {
  const ChooseRoleEvent();
}

class ChooseRoleStarted extends ChooseRoleEvent {
  @override
  List<Object?> get props => [];
}

class ChooseRoleSelection extends ChooseRoleEvent {
  @override
  List<Object?> get props => [];
}

class ChooseRoleCaregiver extends ChooseRoleEvent {
  @override
  List<Object?> get props => [];
}

class ChooseRoleCareReceiver extends ChooseRoleEvent {
  @override
  List<Object?> get props => [];
}