part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesStarted extends NotesEvent {
  @override
  List<Object?> get props => [];
}
