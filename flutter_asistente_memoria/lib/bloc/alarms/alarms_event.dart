part of 'alarms_bloc.dart';

abstract class AlarmsEvent extends Equatable {
  const AlarmsEvent();
}

class AlarmsStarted extends AlarmsEvent {
  @override
  List<Object?> get props => [];
}