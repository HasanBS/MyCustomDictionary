import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Word.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  bool isLoading = false;
  List<Word> randomWords = [];
  
  Future<void> search(String searchValue) async {
    changeLoadingView();
    final response = await Future.wait([
      ApiConnection.searchDictionary(searchValue),
      ApiConnection.searchWord(searchValue),
      ApiConnection.searchNotes(searchValue),
      ApiConnection.searchUsers(searchValue),
    ]);

    if (response is List<List<Object>> &&
        (response[0].isNotEmpty ||
            response[1].isNotEmpty ||
            response[2].isNotEmpty)) {
      changeLoadingView();
      emit(SearchLoadSuccess(response));
    } else {
      changeLoadingView();
      emit(SearchNoMatching());
    }
  }

  Future<void> getRandomWords() async {
    changeLoadingView();
    final response = await Future.value(ApiConnection.getRandomWords(5));
    if(response is List<Word> && response.isNotEmpty){
      changeLoadingView();  
      emit(GetRandomWordsSuccess(response));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(SearchLoadState(isLoading));
  }
}
