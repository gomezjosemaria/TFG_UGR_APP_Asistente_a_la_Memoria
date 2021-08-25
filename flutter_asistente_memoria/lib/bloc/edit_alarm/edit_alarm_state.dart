part of 'edit_alarm_bloc.dart';


class EditAlarmState extends Equatable {

  const EditAlarmState({
    this.status = FormzStatus.pure,
    this.titleInput = const NameInput.pure(),
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    this.repeat = false,
    this.repeatWeekDays = const [false, false, false, false, false, false, false],
    this.active = true,
  });

  final FormzStatus status;
  final NameInput titleInput;
  final TimeOfDay timeInput;
  final bool repeat;
  final List<bool> repeatWeekDays;
  final bool active;

  EditAlarmState copyWith({
    FormzStatus? status,
    NameInput? titleInput,
    TimeOfDay? timeInput,
    bool? repeat,
    List<bool>? repeatWeekDays,
    bool? active,
  }) {
    return EditAlarmState(
      status: status ?? this.status,
      titleInput: titleInput ?? this.titleInput,
      timeInput: timeInput ?? this.timeInput,
      repeat: repeat ?? this.repeat,
      repeatWeekDays: repeatWeekDays ?? this.repeatWeekDays,
      active: active ?? this.active,
    );
  }

  @override
  List<Object> get props => [status, titleInput, timeInput, repeat, repeatWeekDays, active];
}
