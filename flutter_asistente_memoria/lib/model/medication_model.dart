import 'package:equatable/equatable.dart';

class MedicationModel extends Equatable {
  final String name;
  final String time;
  final String frequency;
  final double frequencyNumber;
  final List<bool> repeatWeekDays;

  const MedicationModel(this.name, this.time, this.frequency, this.frequencyNumber, this.repeatWeekDays);

  @override
  List<Object?> get props => [name, time, frequency, frequencyNumber, repeatWeekDays];

  static const empty = MedicationModel('', '', '', 0.0, [false, false, false, false, false, false, false]);
}