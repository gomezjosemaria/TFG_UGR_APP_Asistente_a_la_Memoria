import 'package:equatable/equatable.dart';

class AlarmModel extends Equatable {
  final String tittle;
  final String time;
  final bool repeat;
  final List<bool> repeatWeekDays;

  const AlarmModel(this.tittle, this.time, this.repeat, this.repeatWeekDays);

  @override
  List<Object?> get props => [tittle, time, repeat, repeatWeekDays];

  static const empty = AlarmModel('', '', false, [false, false, false, false, false, false, false]);
}
