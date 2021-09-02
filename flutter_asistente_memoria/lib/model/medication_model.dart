import 'package:flutter_asistente_memoria/model/time_object_model.dart';

class MedicationModel extends TimeObject {
  final String name;
  final String date;
  final String time;
  final String frequency;
  final double frequencyNumber;
  final List<bool> repeatWeekDays;

  const MedicationModel(this.name, this.date, this.time, this.frequency, this.frequencyNumber, this.repeatWeekDays) : super(null);

  @override
  List<Object?> get props => [name, date, time, frequency, frequencyNumber, repeatWeekDays];

  static const empty = MedicationModel('', '', '', '', 0.0, [false, false, false, false, false, false, false]);
}