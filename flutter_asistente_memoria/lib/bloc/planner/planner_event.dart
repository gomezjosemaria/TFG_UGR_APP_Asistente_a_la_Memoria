part of 'planner_bloc.dart';

abstract class PlannerEvent extends Equatable {
  const PlannerEvent();
}

class PlannerStarted extends PlannerEvent {
  @override
  List<Object?> get props => [];
}