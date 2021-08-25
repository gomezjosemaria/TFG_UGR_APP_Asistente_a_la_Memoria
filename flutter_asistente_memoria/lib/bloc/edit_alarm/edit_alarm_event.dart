part of 'edit_alarm_bloc.dart';

abstract class EditAlarmEvent extends Equatable {
  const EditAlarmEvent();
}

class EditAlarmStarted extends EditAlarmEvent {
  final AlarmModel alarm;
  final bool activated;

  EditAlarmStarted(this.alarm, this.activated);

  @override
  List<Object?> get props => [alarm, activated];
}

class EditAlarmTitleChanged extends EditAlarmEvent {
  final String titleInput;

  EditAlarmTitleChanged(this.titleInput);

  @override
  List<Object?> get props => [titleInput];
}

class EditAlarmTimeChanged extends EditAlarmEvent {
  final TimeOfDay timeInput;

  EditAlarmTimeChanged(this.timeInput);

  @override
  List<Object?> get props => [timeInput];
}

class EditAlarmRepeatChanged extends EditAlarmEvent {
  final bool repeat;

  EditAlarmRepeatChanged(this.repeat);

  @override
  List<Object?> get props => [repeat];
}

class EditAlarmRepeatWeekDaysChanged extends EditAlarmEvent {
  final List<bool> repeatWeekDays;

  EditAlarmRepeatWeekDaysChanged(this.repeatWeekDays);

  @override
  List<Object?> get props => [repeatWeekDays];
}

class EditAlarmActiveChanged extends EditAlarmEvent {
  final bool active;

  EditAlarmActiveChanged(this.active);

  @override
  List<Object?> get props => [active];
}

class EditAlarmSubmitted extends EditAlarmEvent {
  final AlarmModel alarmUnmodified;
  final bool activateUnmodified;

  EditAlarmSubmitted(this.alarmUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [alarmUnmodified, activateUnmodified];
}

class EditAlarmDelete extends EditAlarmEvent {
  final AlarmModel alarmUnmodified;
  final bool activateUnmodified;

  EditAlarmDelete(this.alarmUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [alarmUnmodified, activateUnmodified];
}

class EditAlarmDeactivate extends EditAlarmEvent {
  final AlarmModel alarmUnmodified;
  final bool activateUnmodified;

  EditAlarmDeactivate(this.alarmUnmodified, this.activateUnmodified);

  @override
  List<Object> get props => [alarmUnmodified, activateUnmodified];
}