part of 'appointments_bloc.dart';

enum AppointmentsStatus {
  initial,
  appointmentsLoading,
  appointmentsLoadedSuccessfully,
  error
}

class AppointmentsState extends Equatable {

  const AppointmentsState({
    this.status = AppointmentsStatus.initial,
    this.appointmentsActivated = const <AppointmentModel>[],
    this.appointmentsDeactivated = const <AppointmentModel>[],
  });

  final AppointmentsStatus status;
  final List<AppointmentModel> appointmentsActivated;
  final List<AppointmentModel> appointmentsDeactivated;

  AppointmentsState copyWith({
    AppointmentsStatus? status,
    List<AppointmentModel>? appointmentsActivated,
    List<AppointmentModel>? appointmentsDeactivated,
  }) {
    return AppointmentsState(
      status: status ?? this.status,
      appointmentsActivated: appointmentsActivated ?? this.appointmentsActivated,
      appointmentsDeactivated: appointmentsDeactivated ?? this.appointmentsDeactivated,
    );
  }

  @override
  List<Object?> get props => [status, appointmentsActivated, appointmentsDeactivated];
}