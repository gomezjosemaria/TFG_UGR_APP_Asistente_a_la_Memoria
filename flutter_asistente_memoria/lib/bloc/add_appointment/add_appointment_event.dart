part of 'add_appointment_bloc.dart';

abstract class AddAppointmentEvent extends Equatable {
  const AddAppointmentEvent();
}

class AddAppointmentPlaceChanged extends AddAppointmentEvent {
  final String placeInput;

  AddAppointmentPlaceChanged(this.placeInput);

  @override
  List<Object?> get props => [placeInput];
}

class AddAppointmentTimeChanged extends AddAppointmentEvent {
  final TimeOfDay timeInput;

  AddAppointmentTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class AddAppointmentDateChanged extends AddAppointmentEvent {
  final DateTime dateInput;

  AddAppointmentDateChanged(this.dateInput);

  @override
  List<Object?> get props => [dateInput];
}

class AddAppointmentSubmitted extends AddAppointmentEvent {
  const AddAppointmentSubmitted();

  @override
  List<Object> get props => [];
}
