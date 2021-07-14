part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [NoteState];
}

class NoteInitial extends NoteState {}

class NoteLoadSuccess extends NoteState {
  NoteLoadSuccess(this.notes);
  final List<Note> notes;
}

class NoteLoadingState extends NoteState {
  final bool isLoading;
  NoteLoadingState(this.isLoading);
}

class NoteSavingState extends NoteState {
  final bool isLoading;
  NoteSavingState(this.isLoading);
}

class NoteLoginError extends NoteState {
  final String message;
  NoteLoginError(this.message);
}

class NoteValidateState extends NoteState {
  final bool isValidate;
  NoteValidateState(this.isValidate);
}

class NoteUpdateState extends NoteState {
  final bool isUpdated;
  NoteUpdateState(this.isUpdated);
}

class NewNoteState extends NoteState {}

class DeleteNoteState extends NoteState {}
