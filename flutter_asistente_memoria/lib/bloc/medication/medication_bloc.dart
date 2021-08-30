import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/medication_manager.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  MedicationBloc() : super(MedicationState());

  @override
  Stream<MedicationState> mapEventToState(
    MedicationEvent event,
  ) async* {
    if (event is MedicationStarted) {
      yield state.copyWith(status: MedicationStatus.medicationLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await MedicationManager.loadMedication(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await MedicationManager.loadMedication(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: MedicationStatus.medicationLoadedSuccessfully, medicationActivated: MedicationManager.getMedicationActive(), medicationDeactivated: MedicationManager.getMedicationDeactivate());
      } catch (e) {
        yield state.copyWith(status: MedicationStatus.error);
      }
    }
  }
}
