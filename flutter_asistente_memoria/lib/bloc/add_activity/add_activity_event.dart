part of 'add_activity_bloc.dart';

abstract class AddActivityEvent extends Equatable {
  const AddActivityEvent();
}

class AddActivityStarted extends AddActivityEvent {
  final ActivityModel activityModel;

  AddActivityStarted(this.activityModel);

  List<Object?> get props => [activityModel];
}

class AddActivityStart extends AddActivityEvent {
  const AddActivityStart();

  @override
  List<Object?> get props => [];
}

class AddActivityTitleChanged extends AddActivityEvent {
  final String titleInput;

  AddActivityTitleChanged(this.titleInput);

  @override
  List<Object?> get props => [titleInput];
}

class AddActivityStepChanged extends AddActivityEvent {
  final String stepInput;

  AddActivityStepChanged(this.stepInput);

  @override
  List<Object?> get props => [stepInput];
}

class AddActivitySubmitted extends AddActivityEvent {
  const AddActivitySubmitted();

  @override
  List<Object> get props => [];
}

class AddActivityEditedSubmitted extends AddActivityEvent {
  const AddActivityEditedSubmitted();

  @override
  List<Object> get props => [];
}

class AddActivityAddStep extends AddActivityEvent {
  const AddActivityAddStep();

  @override
  List<Object> get props => [];
}

class AddActivityNextStep extends AddActivityEvent {
  const AddActivityNextStep();

  @override
  List<Object> get props => [];
}

class AddActivityPreviousStep extends AddActivityEvent {
  const AddActivityPreviousStep();

  @override
  List<Object> get props => [];
}
