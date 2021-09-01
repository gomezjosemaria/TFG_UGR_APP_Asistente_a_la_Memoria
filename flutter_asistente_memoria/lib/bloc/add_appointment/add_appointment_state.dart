part of 'add_appointment_bloc.dart';

class AddAppointmentState extends Equatable {
  final FormzStatus status;
  final NameInput placeInput;
  final TimeOfDay timeInput;
  final DateTime dateInput;

  AddAppointmentState({
    this.status = FormzStatus.pure,
    this.placeInput = const NameInput.pure(),
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    DateTime? dateTime,
  }) : this.dateInput = dateTime ?? DateTime.now().add(const Duration(days: 1));

  AddAppointmentState copyWith({
    FormzStatus? status,
    NameInput? placeInput,
    TimeOfDay? timeInput,
    DateTime? dateInput,
  }) {
    return AddAppointmentState(
      status: status ?? this.status,
      placeInput: placeInput ?? this.placeInput,
      timeInput: timeInput ?? this.timeInput,
      dateTime: dateInput ?? this.dateInput,
    );
  }

  @override
  List<Object> get props => [status, placeInput, timeInput, dateInput];
}
