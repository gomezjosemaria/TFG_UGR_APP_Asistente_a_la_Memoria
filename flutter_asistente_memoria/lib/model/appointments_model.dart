import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final String place;
  final String date;
  final String time;

  const AppointmentModel(this.place, this.date, this.time);

  @override
  List<Object?> get props => [place, date, time];

  static const empty = AppointmentModel('', '', '');
}
