part of 'bond_care_receiver_bloc.dart';

abstract class BondCareReceiverEvent extends Equatable {
  const BondCareReceiverEvent();
}

class BondCareReceiverEmailInputChanged extends BondCareReceiverEvent {
  final String emailInput;

  BondCareReceiverEmailInputChanged(this.emailInput);

  @override
  List<Object?> get props => [emailInput];
}

class BondCareReceiverCodeInputChanged extends BondCareReceiverEvent {
  final String codeInput;

  BondCareReceiverCodeInputChanged(this.codeInput);

  @override
  List<Object?> get props => [codeInput];
}

class BondCareReceiverSubmitted extends BondCareReceiverEvent {
  const BondCareReceiverSubmitted();

  @override
  List<Object?> get props => [];
}