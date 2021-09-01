part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class AppointmentsStarted extends AppointmentsEvent {
  @override
  List<Object?> get props => [];
}