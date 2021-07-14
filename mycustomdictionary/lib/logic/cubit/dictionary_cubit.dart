import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Word.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  bool isLoading = false;
  bool isUpdated = false;

  DictionaryCubit() : super(DictionaryInitial());

  Future<void> followDictionary(int userID, int dicID) async {
    final res = await ApiConnection.followDictionary(userID, dicID);
    emit(DictionaryFollowState());
    print(res);
  }

  Future<void> unfollowDictionary(int userID, int dicID) async {
    final res = await ApiConnection.unfollowDictionary(userID, dicID);
    emit(DictionaryUnFollowState());
    print(res);
  }

  Future<void> getDictionary(Folder _folder) async {
    //changeLoadingModel();
    final dictionaries =
        await ApiConnection.getDictionariesByFolder(_folder.folderID);
    if (dictionaries is List<Dictionary>) {
      emit(DictionaryLoadSuccess(dictionaries));
    }
    //changeLoadingModel();
  }

  Future<void> newDictionary(
      int folderID, String title, String decription) async {
    final response =
        await ApiConnection.createDictionary(folderID, title, decription);
    if (response is Dictionary) {
      emit(NewDictionaryState());
    }
  }

  Future<void> getWords(Dictionary dictionary) async {
    final words =
        await ApiConnection.getWordsByDictionary(dictionary.dictionaryID);

    if (words is List<Word>) {
      emit(WordsLoadSuccess(words));
    }
  }

  Future<void> deleteDictionary(int dictionaryID) async {
    final response = await ApiConnection.deleteDictionary(dictionaryID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      //isDeleted = true;
      emit(DeleteDictionaryState());
    }
  }

  void toFollowingState(int userId, int dicId) async {
    final response = await ApiConnection.dictionaryFollowCheck(userId, dicId);
    if (response)
      emit(DictionaryFollowState());
    else
      emit(DictionaryUnFollowState());
  }

  void changeLoadingModel() {
    isLoading = !isLoading;
    emit(DictionaryLoadingState(isLoading));
  }
}
