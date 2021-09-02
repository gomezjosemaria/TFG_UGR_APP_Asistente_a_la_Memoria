part of 'add_medication_bloc.dart';

class AddMedicationState extends Equatable {
  final FormzStatus status;
  final NameInput nameInput;
  final DateTime dateInput;
  final TimeOfDay timeInput;
  final String frequency;
  final String frequencyNumber;
  final List<bool> repeatWeekDays;

  AddMedicationState({
    this.status = FormzStatus.pure,
    this.nameInput = const NameInput.pure(),
    DateTime? dateTime,
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    this.frequency = "Diariamente",
    this.frequencyNumber = '0.0',
    this.repeatWeekDays = const [false, false, false, false, false, false, false],
  }) : this.dateInput = dateTime ?? DateTime.now().add(const Duration(days: 1));

  AddMedicationState copyWith({
    FormzStatus? status,
    NameInput? nameInput,
    DateTime? dateInput,
    TimeOfDay? timeInput,
    String? frequency,
    String? frequencyNumber,
    List<bool>? repeatWeekDays,
  }) {
    return AddMedicationState(
      status: status ?? this.status,
      nameInput: nameInput ?? this.nameInput,
      dateTime: dateInput ?? this.dateInput,
      timeInput: timeInput ?? this.timeInput,
      frequency: frequency ?? this.frequency,
      frequencyNumber: frequencyNumber ?? this.frequencyNumber,
      repeatWeekDays: repeatWeekDays ?? this.repeatWeekDays,
    );
  }

  @override
  List<Object?> get props => [status, nameInput, dateInput, timeInput, frequency, frequencyNumber, repeatWeekDays];
}
