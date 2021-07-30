part of 'add_alarm_bloc.dart';

class AddAlarmState extends Equatable {

  const AddAlarmState({
    this.status = FormzStatus.pure,
    this.titleInput = const NameInput.pure(),
    this.timeInput = const TimeOfDay(hour: 7, minute: 0),
    this.repeat = false,
    this.repeatWeekDays = const [false, false, false, false, false, false, false],
  });

  final FormzStatus status;
  final NameInput titleInput;
  final TimeOfDay timeInput;
  final bool repeat;
  final List<bool> repeatWeekDays;

  AddAlarmState copyWith({
    FormzStatus? status,
    NameInput? titleInput,
    TimeOfDay? timeInput,
    bool? repeat,
    List<bool>? repeatWeekDays,
  }) {
    return AddAlarmState(
      status: status ?? this.status,
      titleInput: titleInput ?? this.titleInput,
      timeInput: timeInput ?? this.timeInput,
      repeat: repeat ?? this.repeat,
      repeatWeekDays: repeatWeekDays ?? this.repeatWeekDays,
    );
  }

  @override
  List<Object> get props => [status, titleInput, timeInput, repeat, repeatWeekDays];
}
