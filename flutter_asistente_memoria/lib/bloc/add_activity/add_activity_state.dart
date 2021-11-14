part of 'add_activity_bloc.dart';

class AddActivityState extends Equatable {
  const AddActivityState({
    this.status = FormzStatus.pure,
    this.titleInput = const NameInput.pure(),
    this.stepInd = 0,
    this.steps = const [''],
    this.activityInitial = ActivityModel.empty,
  });

  final FormzStatus status;
  final NameInput titleInput;
  final int stepInd;
  final List<String> steps;
  final ActivityModel activityInitial;

  AddActivityState copyWith({
    FormzStatus? status,
    NameInput? titleInput,
    int? stepInd,
    List<String>? steps,
    ActivityModel? activityInitial,
  }) {
    return AddActivityState(
      status: status ?? this.status,
      titleInput: titleInput ?? this.titleInput,
      stepInd: stepInd ?? this.stepInd,
      steps: steps ?? this.steps,
      activityInitial: activityInitial ?? this.activityInitial,
    );
  }

  @override
  List<Object> get props =>
      [status, titleInput, stepInd, steps, activityInitial];
}
