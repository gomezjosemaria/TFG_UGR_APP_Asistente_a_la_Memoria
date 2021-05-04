part of 'role_bloc.dart';

enum RoleStatus {unknown, unselected, caregiver, careReceiver}

class RoleState extends Equatable {

  final RoleStatus status;

  const RoleState({this.status = RoleStatus.unknown});

  RoleState unknown() {
    return RoleState(status: RoleStatus.unknown);
  }

  RoleState unselected() {
    return RoleState(status: RoleStatus.unselected);
  }

  RoleState caregiver() {
    return RoleState(status: RoleStatus.caregiver);
  }

  RoleState careReceiver() {
    return RoleState(status: RoleStatus.careReceiver);
  }

  @override
  List<Object> get props => [];
}
