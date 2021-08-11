part of 'bond_care_receiver_bloc.dart';

class BondCareReceiverState extends Equatable {

  const BondCareReceiverState ({
    this.status = FormzStatus.pure,
    this.emailInput = const NameInput.pure(),
    this.codeInput = const NameInput.pure(),
  });

  final FormzStatus status;
  final NameInput emailInput;
  final NameInput codeInput;

  BondCareReceiverState copyWith({
    FormzStatus? status,
    NameInput? emailInput,
    NameInput? codeInput,
  }) {
    return BondCareReceiverState(
      status: status ?? this.status,
      emailInput: emailInput ?? this.emailInput,
      codeInput: codeInput ?? this.codeInput,
    );
  }

  @override
  List<Object?> get props => [status, emailInput, codeInput];
}
