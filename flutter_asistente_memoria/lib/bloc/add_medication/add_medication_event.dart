part of 'add_medication_bloc.dart';

abstract class AddMedicationEvent extends Equatable {
  const AddMedicationEvent();
}

class AddMedicationNameChanged extends AddMedicationEvent {
  final String nameInput;

  AddMedicationNameChanged(this.nameInput);

  @override
  List<Object?> get props => [nameInput];
}

class AddMedicationDateChanged extends AddMedicationEvent {
  final DateTime dateInput;

  AddMedicationDateChanged(this.dateInput);

  @override
  List<Object?> get props => [dateInput];
}

class AddMedicationTimeChanged extends AddMedicationEvent {
  final TimeOfDay timeInput;

  AddMedicationTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class AddMedicationFrequencyChanged extends AddMedicationEvent {
  final String frequency;

  AddMedicationFrequencyChanged(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

class AddMedicationFrequencyNumberChanged extends AddMedicationEvent {
  final String frequencyNumber;

  AddMedicationFrequencyNumberChanged(this.frequencyNumber);

  @override
  List<Object?> get props => [frequencyNumber];
}

class AddMedicationRepeatWeekDaysChanged extends AddMedicationEvent {
  final List<bool> repeatWeekDays;

  AddMedicationRepeatWeekDaysChanged(this.repeatWeekDays);

  @override
  List<Object?> get props => [repeatWeekDays];
}

class AddMedicationSubmitted extends AddMedicationEvent {
  const AddMedicationSubmitted();

  @override
  List<Object> get props => [];
}
