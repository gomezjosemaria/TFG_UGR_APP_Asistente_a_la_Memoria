part of 'add_medication_bloc.dart';

class AddMedicationState extends Equatable {

  const AddMedicationState({
    this.status = FormzStatus.pure,
    this.nameInput = const NameInput.pure(),
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    this.frequency = "Diariamente",
    this.frequencyNumber = '0.0',
    this.repeatWeekDays = const [false, false, false, false, false, false, false],
  });

  final FormzStatus status;
  final NameInput nameInput;
  final TimeOfDay timeInput;
  final String frequency;
  final String frequencyNumber;
  final List<bool> repeatWeekDays;

  AddMedicationState copyWith({
    FormzStatus? status,
    NameInput? nameInput,
    TimeOfDay? timeInput,
    String? frequency,
    String? frequencyNumber,
    List<bool>? repeatWeekDays,
  }) {
    return AddMedicationState(
      status: status ?? this.status,
      nameInput: nameInput ?? this.nameInput,
      timeInput: timeInput ?? this.timeInput,
      frequency: frequency ?? this.frequency,
      frequencyNumber: frequencyNumber ?? this.frequencyNumber,
      repeatWeekDays: repeatWeekDays ?? this.repeatWeekDays,
    );
  }

  @override
  List<Object?> get props => [status, nameInput, timeInput, frequency, frequencyNumber, repeatWeekDays];
}
