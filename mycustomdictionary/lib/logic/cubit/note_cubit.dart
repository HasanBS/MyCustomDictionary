import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final Folder _folder;
  // final TextEditingController _controllerTittle = TextEditingController();
  // final TextEditingController _controllerDetails = TextEditingController();

  bool isLoading = false;
  bool isUpdated = false;

  NoteCubit(this._folder) : super(NoteInitial());

  Future<void> getNotes() async {
    changeLoadingNote();
    final notes = (await ApiConnection.getNotesByFolder(_folder.folderID));
    if (notes is List<Note>) {
      changeLoadingNote();
      emit(NoteLoadSuccess(notes));
    } else {
      changeLoadingNote();
    }
  }

  Future<void> newNote(int folderID, String title, String decription) async {
    final response =
        await ApiConnection.createNote(folderID, title, decription);
    if (response is Note) {
      emit(NewNoteState());
    }
  }

  void updateNote(Note note) async {
    changeLoadingNote();
    final response = await ApiConnection.editNote(note);
    if (response.statusCode == 204 || response.statusCode == 200)
      changeNoteUpdated();
    changeLoadingNote();
  }

  Future<void> deleteNote(int noteID) async {
    final response = await ApiConnection.deleteNote(noteID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      //isDeleted = true;
      emit(DeleteNoteState());
    }
  }

  void changeLoadingNote() {
    isLoading = !isLoading;
    emit(NoteLoadingState(isLoading));
  }

  void changeNoteUpdated() {
    isUpdated = !isUpdated;
    emit(NoteUpdateState(isUpdated));
  }
}
