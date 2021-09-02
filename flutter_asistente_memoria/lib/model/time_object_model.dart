import 'package:equatable/equatable.dart';

abstract class TimeObject extends Equatable {
  final time;

  const TimeObject(this.time);
}