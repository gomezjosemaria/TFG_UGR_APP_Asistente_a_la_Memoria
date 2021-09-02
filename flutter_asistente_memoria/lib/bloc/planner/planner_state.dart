part of 'planner_bloc.dart';

enum PlannerStatus {
  initial,
  loading,
  loadedSuccessfully,
  error
}

class PlannerState extends Equatable {
  final PlannerStatus status;

  const PlannerState({
    this.status = PlannerStatus.initial
  });

  PlannerState copyWith({
    PlannerStatus? status,
  }) {
    return PlannerState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
