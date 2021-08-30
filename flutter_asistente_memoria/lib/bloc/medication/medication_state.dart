part of 'medication_bloc.dart';

enum MedicationStatus {
  initial,
  medicationLoading,
  medicationLoadedSuccessfully,
  error
}

class MedicationState extends Equatable {
  const MedicationState({
    this.status = MedicationStatus.initial,
    this.medicationActivated = const <MedicationModel>[],
    this.medicationDeactivated = const <MedicationModel>[],
  });

    final MedicationStatus status;
  final List<MedicationModel> medicationActivated;
  final List<MedicationModel> medicationDeactivated;

  MedicationState copyWith({
    MedicationStatus? status,
    List<MedicationModel>? medicationActivated,
    List<MedicationModel>? medicationDeactivated,
  }) {
    return MedicationState(
      status: status ?? this.status,
      medicationActivated: medicationActivated ?? this.medicationActivated,
      medicationDeactivated: medicationDeactivated ?? this.medicationDeactivated,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, medicationActivated, medicationDeactivated];
}
