part of 'activities_bloc.dart';

enum ActivitiesStatus {
  initial,
  activitiesLoading,
  activitiesLoadedSuccessfully,
  error
}

class ActivitiesState extends Equatable {

  const ActivitiesState({
    this.status = ActivitiesStatus.initial,
    this.activities = const <ActivityModel>[],
  });

  final ActivitiesStatus status;
  final List<ActivityModel> activities;

  ActivitiesState copyWith({
    ActivitiesStatus? status,
    List<ActivityModel>? activities,
  }) {
    return ActivitiesState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object?> get props => [status, activities, activities];
}
