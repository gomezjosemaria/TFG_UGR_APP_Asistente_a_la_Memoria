part of 'choose_role_bloc.dart';

enum ChooseRoleStatus {
  unselected,
  caregiverSelected,
  careReceiverSelected,
  caregiverSelectionProgress,
  careReceiverSelectionProgress,
  selectionSuccess,
  error
}

class ChooseRoleState extends Equatable {

  final ChooseRoleStatus status;

  const ChooseRoleState({this.status = ChooseRoleStatus.unselected});

  ChooseRoleState unselected() {
    return ChooseRoleState(status: ChooseRoleStatus.unselected);
  }

  ChooseRoleState caregiverSelected() {
    return ChooseRoleState(status: ChooseRoleStatus.caregiverSelected);
  }

  ChooseRoleState careReceiverSelected() {
    return ChooseRoleState(status: ChooseRoleStatus.careReceiverSelected);
  }

  ChooseRoleState caregiverSelectionProgress() {
    return ChooseRoleState(status: ChooseRoleStatus.caregiverSelectionProgress);
  }

  ChooseRoleState careReceiverSelectionProgress() {
    return ChooseRoleState(status: ChooseRoleStatus.careReceiverSelectionProgress);
  }

  ChooseRoleState selectionSuccess() {
    return ChooseRoleState(status: ChooseRoleStatus.selectionSuccess);
  }

  ChooseRoleState error() {
    return ChooseRoleState(status: ChooseRoleStatus.error);
  }

  @override
  List<Object> get props => [status];
}
