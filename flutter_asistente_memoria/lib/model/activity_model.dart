import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  final String tittle;
  final List<String> steps;

  const ActivityModel(this.tittle, this.steps) : super();

  @override
  List<Object?> get props => [tittle, steps];

  static const empty = ActivityModel('', ['']);
}
