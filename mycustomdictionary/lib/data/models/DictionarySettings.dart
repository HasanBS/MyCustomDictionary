import 'dart:convert';


class DictionarySettings {
  bool dictionarySettingsID;
  bool hideDictionary;
  bool hideComments;
  bool hideRating;
  bool isLanguageDictionary;
  DictionarySettings(
    this.dictionarySettingsID,
    this.hideDictionary,
    this.hideComments,
    this.hideRating,
    this.isLanguageDictionary,
  );

  Map<String, dynamic> toMap() {
    return {
      'dictionarySettingsId': dictionarySettingsID,
      'hideDictionary': hideDictionary,
      'hideComments': hideComments,
      'hideRating': hideRating,
      'isLanguageDictionary': isLanguageDictionary,
    };
  }

  factory DictionarySettings.fromMap(Map<String, dynamic> map) {
    return DictionarySettings(
      map['dictionarySettingsId'],
      map['hideDictionary'],
      map['hideComments'],
      map['hideRating'],
      map['isLanguageDictionary'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DictionarySettings.fromJson(String source) => DictionarySettings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DictionarySettings(dictionarySettingsID: $dictionarySettingsID, hideDictionary: $hideDictionary, hideComments: $hideComments, hideRating: $hideRating, isLanguageDictionary: $isLanguageDictionary)';
  }
}
