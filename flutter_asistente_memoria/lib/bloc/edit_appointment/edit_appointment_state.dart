part of 'edit_appointment_bloc.dart';

class EditAppointmentState extends Equatable {
  final FormzStatus status;
  final NameInput placeInput;
  final TimeOfDay timeInput;
  final DateTime dateInput;
  final bool active;

  EditAppointmentState({
    this.status = FormzStatus.pure,
    this.placeInput = const NameInput.pure(),
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    DateTime? dateTime,
    this.active = true,
  }) : this.dateInput = dateTime ?? DateTime.now().add(const Duration(days: 1));

  EditAppointmentState copyWith({
    FormzStatus? status,
    NameInput? placeInput,
    TimeOfDay? timeInput,
    DateTime? dateInput,
    bool? active,
  }) {
    return EditAppointmentState(
      status: status ?? this.status,
      placeInput: placeInput ?? this.placeInput,
      timeInput: timeInput ?? this.timeInput,
      dateTime: dateInput ?? this.dateInput,
      active: active ?? this.active,
    );
  }

  @override
  List<Object> get props => [status, placeInput, timeInput, dateInput, active];
}

class EditAppointmentDeleteState extends EditAppointmentState {}

class EditAppointmentDeletingState extends EditAppointmentDeleteState {}

class EditAppointmentDeleteSuccessState extends EditAppointmentDeleteState {}

class EditAppointmentDeleteErrorState extends EditAppointmentDeleteState {}

class EditAppointmentDeactivateState extends EditAppointmentState {}

class EditAppointmentDeactivatingState extends EditAppointmentDeactivateState {}

class EditAppointmentDeactivateSuccessState extends EditAppointmentDeactivateState {}

class EditAppointmentDeactivateErrorState extends EditAppointmentDeactivateState {}