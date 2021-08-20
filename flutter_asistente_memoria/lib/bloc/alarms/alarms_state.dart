part of 'alarms_bloc.dart';

enum AlarmsStatus {
  initial,
  alarmsLoading,
  alarmsLoadedSuccessfully,
  error
}

class AlarmsState extends Equatable {

  const AlarmsState({
    this.status = AlarmsStatus.initial,
    this.alarmsActivated = const <AlarmModel>[],
    this.alarmsDeactivated = const <AlarmModel>[],
  });

  final AlarmsStatus status;
  final List<AlarmModel> alarmsActivated;
  final List<AlarmModel> alarmsDeactivated;

  AlarmsState copyWith({
    AlarmsStatus? status,
    List<AlarmModel>? alarmsActivated,
    List<AlarmModel>? alarmsDeactivated,
  }) {
    return AlarmsState(
      status: status ?? this.status,
      alarmsActivated: alarmsActivated ?? this.alarmsActivated,
      alarmsDeactivated: alarmsDeactivated ?? this.alarmsDeactivated,
    );
  }

  @override
  List<Object?> get props => [status, alarmsActivated, alarmsDeactivated];
}
