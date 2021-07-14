import 'dart:convert';

class Word {
  int wordID;
  String word;
  String description;
  String details;
  int dictionaryID;

  Word(
    this.wordID,
    this.word,
    this.description,
    this.details,
    this.dictionaryID,
  );

  Map<String, dynamic> toMap() {
    return {
      'wordId': wordID,
      'Word': word,
      'description': description,
      'details': details,
      'dictionaryId': dictionaryID,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      map['wordId'],
      map['Word'],
      map['description'],
      map['details'],
      map['dictionaryId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Word(wordID: $wordID, word: $word, description: $description, details: $details, dictionaryID: $dictionaryID)';
  }
}
