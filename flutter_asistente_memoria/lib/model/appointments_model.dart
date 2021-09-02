import 'package:flutter_asistente_memoria/model/time_object_model.dart';

class AppointmentModel extends TimeObject {
  final String place;
  final String date;
  final String time;

  const AppointmentModel(this.place, this.date, this.time) : super(null);

  @override
  List<Object?> get props => [place, date, time];

  static const empty = AppointmentModel('', '', '');
}
