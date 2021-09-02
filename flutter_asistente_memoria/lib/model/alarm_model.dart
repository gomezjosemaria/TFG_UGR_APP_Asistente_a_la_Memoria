import 'package:flutter_asistente_memoria/model/time_object_model.dart';

class AlarmModel extends TimeObject {
  final String tittle;
  final String time;
  final bool repeat;
  final List<bool> repeatWeekDays;

  const AlarmModel(this.tittle, this.time, this.repeat, this.repeatWeekDays) : super(null);

  @override
  List<Object?> get props => [tittle, time, repeat, repeatWeekDays];

  static const empty = AlarmModel('', '', false, [false, false, false, false, false, false, false]);
}
