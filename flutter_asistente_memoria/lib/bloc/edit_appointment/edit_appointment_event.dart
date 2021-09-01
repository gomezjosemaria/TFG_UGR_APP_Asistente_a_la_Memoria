part of 'edit_appointment_bloc.dart';

abstract class EditAppointmentEvent extends Equatable {
  const EditAppointmentEvent();
}

class EditAppointmentStarted extends EditAppointmentEvent {
  final AppointmentModel appointment;
  final bool activated;

  EditAppointmentStarted(this.appointment, this.activated);

  @override
  List<Object?> get props => [appointment, activated];
}

class EditAppointmentPlaceChanged extends EditAppointmentEvent {
  final String placeInput;

  EditAppointmentPlaceChanged(this.placeInput);

  @override
  List<Object?> get props => [placeInput];
}

class EditAppointmentTimeChanged extends EditAppointmentEvent {
  final TimeOfDay timeInput;

  EditAppointmentTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class EditAppointmentDateChanged extends EditAppointmentEvent {
  final DateTime dateInput;

  EditAppointmentDateChanged(this.dateInput);

  @override
  List<Object?> get props => [dateInput];
}

class EditAppointmentSubmitted extends EditAppointmentEvent {
  final AppointmentModel appointmentUnmodified;
  final bool activateUnmodified;

  EditAppointmentSubmitted(this.appointmentUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [appointmentUnmodified, activateUnmodified];
}

class EditAppointmentDelete extends EditAppointmentEvent {
  final AppointmentModel appointmentUnmodified;
  final bool activateUnmodified;

  EditAppointmentDelete(this.appointmentUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [appointmentUnmodified, activateUnmodified];
}

class EditAppointmentDeactivate extends EditAppointmentEvent {
  final AppointmentModel appointmentUnmodified;
  final bool activateUnmodified;

  EditAppointmentDeactivate(this.appointmentUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [appointmentUnmodified, activateUnmodified];
}
