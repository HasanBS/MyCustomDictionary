part of 'dictionary_cubit.dart';

abstract class DictionaryState extends Equatable {
  const DictionaryState();

  @override
  List<Object> get props => [];
}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoadSuccess extends DictionaryState {
  DictionaryLoadSuccess(this.dictonaries);
  final List<Dictionary> dictonaries;
}

class WordsLoadSuccess extends DictionaryState {
  WordsLoadSuccess(this.words);
  final List<Word> words;
}

class DictionaryUpdate extends DictionaryState {
  DictionaryUpdate(this.update);
  final bool update;
}

class DictionaryLoadingState extends DictionaryState {
  final bool isLoading;
  DictionaryLoadingState(this.isLoading);
}

class DictionaryFollowState extends DictionaryState {}

class DictionaryUnFollowState extends DictionaryState {}

class NewDictionaryState extends DictionaryState {}

class EditDictionaryState extends DictionaryState {}

class DeleteDictionaryState extends DictionaryState {}
