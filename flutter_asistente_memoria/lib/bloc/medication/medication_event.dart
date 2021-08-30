part of 'medication_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();
}

class MedicationStarted extends MedicationEvent {
  @override
  List<Object?> get props => [];
}
