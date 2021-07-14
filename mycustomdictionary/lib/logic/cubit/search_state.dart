part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
}

class GetRandomWordsSuccess extends SearchState{
  GetRandomWordsSuccess(this.randomWords);
  final List<Word> randomWords;
}
class SearchLoadSuccess extends SearchState {
  SearchLoadSuccess(this.searchList);
  final List<List<dynamic>> searchList;
}

class SearchLoadState extends SearchState {
  final bool isLoading;
  SearchLoadState(this.isLoading);
}

class SearchNoMatching extends SearchState {}
