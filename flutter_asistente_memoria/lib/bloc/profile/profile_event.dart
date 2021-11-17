part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileLogOut extends ProfileEvent {
  const ProfileLogOut();

  @override
  List<Object> get props => [];
}