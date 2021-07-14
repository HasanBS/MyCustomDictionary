part of 'word_cubit.dart';

abstract class WordState extends Equatable {
  const WordState();

  @override
  List<Object> get props => [];
}

class WordInitial extends WordState {}

class WordLoadSuccess extends WordState {
  WordLoadSuccess(this.words);
  final List<Word> words;
}

class WordUpdateState extends WordState {
  final bool isUpdated;
  WordUpdateState(this.isUpdated);
}

class WordLoadingState extends WordState {
  final bool isLoading;
  WordLoadingState(this.isLoading);
}

class WordLoginError extends WordState {
  final String message;
  WordLoginError(this.message);
}

class NewWordState extends WordState {}

//class DeleteWordState extends WordState {}
