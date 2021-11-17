part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileLogOut extends ProfileEvent {
  const ProfileLogOut();

  @override
  List<Object> get props => [];
}

class ProfileSimplify extends ProfileEvent {
  final bool simplify;

  const ProfileSimplify(this.simplify);

  @override
  List<Object> get props => [simplify];
}