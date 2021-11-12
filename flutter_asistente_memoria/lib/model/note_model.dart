import 'package:flutter_asistente_memoria/model/time_object_model.dart';

class NoteModel extends TimeObject {
  final String text;
  final String time;

  const NoteModel(this.text, this.time) : super(null);

  @override
  List<Object?> get props => [text, time];

  static const empty = NoteModel('', '');
}