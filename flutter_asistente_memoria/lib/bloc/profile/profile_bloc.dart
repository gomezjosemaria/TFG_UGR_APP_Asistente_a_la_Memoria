import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLogOut) {
      yield* _mapProfileLogOutToState(event, state);
    }
  }

  Stream<ProfileState> _mapProfileLogOutToState(ProfileLogOut event, ProfileState state) async* {
    yield state.copyWith(status: ProfileStatus.login_out);
    try {
      Authentication.singOut();
      yield state.copyWith(status: ProfileStatus.log_out);
    } on Exception {
      yield state.copyWith(status: ProfileStatus.error);
    }
  }
}
