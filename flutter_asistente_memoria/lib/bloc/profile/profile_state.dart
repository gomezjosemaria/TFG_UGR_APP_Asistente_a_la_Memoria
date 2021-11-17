part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  login_out,
  log_out,
  error,
}

class ProfileState extends Equatable {
  ProfileState({
    this.status = ProfileStatus.initial,
  });

  final ProfileStatus status;

  ProfileState copyWith({
    ProfileStatus? status,
  }) {
    return ProfileState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
