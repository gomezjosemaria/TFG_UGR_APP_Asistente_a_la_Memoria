import 'package:equatable/equatable.dart';

class AlarmModel extends Equatable {
  final String id;
  final String tittle;
  final String time;
  final String repeat;
  final String repeatWeekDays;

  const AlarmModel(this.id, this.tittle, this.time, this.repeat, this.repeatWeekDays);

  @override
  List<Object?> get props => [id, tittle, time, repeat, repeatWeekDays];

  static const empty = AlarmModel('', '', '', '', '');
}
