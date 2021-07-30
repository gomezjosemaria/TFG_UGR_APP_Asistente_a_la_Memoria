part of 'add_alarm_bloc.dart';

abstract class AddAlarmEvent extends Equatable {
  const AddAlarmEvent();
}

class AddAlarmTitleChanged extends AddAlarmEvent {
  final String titleInput;

  AddAlarmTitleChanged(this.titleInput);

  @override
  List<Object?> get props => [titleInput];
}

class AddAlarmTimeChanged extends AddAlarmEvent {
  final TimeOfDay timeInput;

  AddAlarmTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class AddAlarmRepeatChanged extends AddAlarmEvent {
  final bool repeat;

  AddAlarmRepeatChanged(this.repeat);

  @override
  List<Object?> get props => [repeat];
}

class AddAlarmRepeatWeekDaysChanged extends AddAlarmEvent {
  final List<bool> repeatWeekDays;

  AddAlarmRepeatWeekDaysChanged(this.repeatWeekDays);

  @override
  List<Object?> get props => [repeatWeekDays];
}

class AddAlarmSubmitted extends AddAlarmEvent {
  const AddAlarmSubmitted();

  @override
  List<Object> get props => [];
}