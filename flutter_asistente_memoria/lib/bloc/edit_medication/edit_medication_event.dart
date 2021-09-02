part of 'edit_medication_bloc.dart';

abstract class EditMedicationEvent extends Equatable {
  const EditMedicationEvent();
}

class EditMedicationStarted extends EditMedicationEvent {
  final MedicationModel medication;
  final bool activated;

  EditMedicationStarted(this.medication, this.activated);

  @override
  List<Object?> get props => [medication, activated];
}

class EditMedicationNameChanged extends EditMedicationEvent {
  final String nameInput;

  EditMedicationNameChanged(this.nameInput);

  @override
  List<Object?> get props => [nameInput];
}

class EditMedicationDateChanged extends EditMedicationEvent {
  final DateTime dateInput;

  EditMedicationDateChanged(this.dateInput);

  @override
  List<Object?> get props => [dateInput];
}

class EditMedicationTimeChanged extends EditMedicationEvent {
  final TimeOfDay timeInput;

  EditMedicationTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class EditMedicationFrequencyChanged extends EditMedicationEvent {
  final String frequency;

  EditMedicationFrequencyChanged(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

class EditMedicationFrequencyNumberChanged extends EditMedicationEvent {
  final String frequencyNumber;

  EditMedicationFrequencyNumberChanged(this.frequencyNumber);

  @override
  List<Object?> get props => [frequencyNumber];
}

class EditMedicationRepeatWeekDaysChanged extends EditMedicationEvent {
  final List<bool> repeatWeekDays;

  EditMedicationRepeatWeekDaysChanged(this.repeatWeekDays);

  @override
  List<Object?> get props => [repeatWeekDays];
}

class EditMedicationActiveChanged extends EditMedicationEvent {
  final bool active;

  EditMedicationActiveChanged(this.active);

  @override
  List<Object?> get props => [active];
}

class EditMedicationSubmitted extends EditMedicationEvent {
  final MedicationModel medicationUnmodified;
  final bool activateUnmodified;

  EditMedicationSubmitted(this.medicationUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [medicationUnmodified, activateUnmodified];
}

class EditMedicationDelete extends EditMedicationEvent {
  final MedicationModel alarmUnmodified;
  final bool activateUnmodified;

  EditMedicationDelete(this.alarmUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [alarmUnmodified, activateUnmodified];
}

class EditMedicationDeactivate extends EditMedicationEvent {
  final MedicationModel alarmUnmodified;
  final bool activateUnmodified;

  EditMedicationDeactivate(this.alarmUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [alarmUnmodified, activateUnmodified];
}
