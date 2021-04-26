part of 'choose_role_bloc.dart';

enum ChooseRoleStatus {unknown, unselected, caregiver, careReceiver}

class ChooseRoleState extends Equatable {

  final ChooseRoleStatus status;

  const ChooseRoleState({this.status = ChooseRoleStatus.unknown});

  ChooseRoleState unknown() {
    return ChooseRoleState(status: ChooseRoleStatus.unknown);
  }

  ChooseRoleState unselected() {
    return ChooseRoleState(status: ChooseRoleStatus.unselected);
  }

  ChooseRoleState caregiver() {
    return ChooseRoleState(status: ChooseRoleStatus.caregiver);
  }

  ChooseRoleState careReceiver() {
    return ChooseRoleState(status: ChooseRoleStatus.careReceiver);
  }

  @override
  List<Object> get props => [];
}
