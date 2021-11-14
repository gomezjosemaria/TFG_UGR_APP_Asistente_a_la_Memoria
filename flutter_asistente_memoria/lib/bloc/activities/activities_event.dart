part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
}

class ActivitiesStarted extends ActivitiesEvent {
  @override
  List<Object?> get props => [];
}
