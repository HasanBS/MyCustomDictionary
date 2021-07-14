import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/data/models/session.dart';

part 'word_state.dart';

class WordCubit extends Cubit<WordState> {
  final Dictionary _dictionary;

  WordCubit(this._dictionary) : super(WordInitial());
  late bool readOnly = !(_dictionary.userID == Session.activeUser!.userID);
  bool isLoading = false;
  bool isUpdated = false;
  bool isLoginFail = false;

  Future<void> getWords() async {
    changeLoadingWord();
    final words =
        (await ApiConnection.getWordsByDictionary(_dictionary.dictionaryID));
    if (words is List<Word>) {
      changeLoadingWord();
      emit(WordLoadSuccess(words));
    } else {
      isLoginFail = true;
      changeLoadingWord();
      emit(WordLoginError("Word Load is not succesful"));
    }
  }

  void updateWord(Word word) async {
    changeLoadingWord();
    final response = await ApiConnection.editWord(word);
    if (response.statusCode == 204 || response.statusCode == 200)
      changeWordUpdated();
    else {
      isLoginFail = true;
      emit(WordLoginError("Word Update is not succesful"));
    }
    changeLoadingWord();
  }

  Future<void> newWord(
      int folderID, String title, String decription, String details) async {
    final response =
        await ApiConnection.createWord(folderID, title, decription, details);
    if (response is Word) {
      emit(NewWordState());
    }
  }

  Future<void> deleteWord(int wordID) async {
    final response = await ApiConnection.deleteWord(wordID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      //isDeleted = true;
      //emit(DeleteWordState());
    }
  }

  void changeLoadingWord() {
    isLoading = !isLoading;
    emit(WordLoadingState(isLoading));
  }

  void changeWordUpdated() {
    isUpdated = !isUpdated;
    emit(WordUpdateState(isUpdated));
  }
}
