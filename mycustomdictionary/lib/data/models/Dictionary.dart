import 'dart:convert';

class Dictionary {
  int dictionaryID;
  String dictionaryName;
  String description;
  int rating;
  int dailyVisit;
  int dictionarySettingsID;
  int folderID;
  int userID;

  Dictionary(
    this.dictionaryID,
    this.dictionaryName,
    this.description,
    this.rating,
    this.dailyVisit,
    this.dictionarySettingsID,
    this.folderID,
    this.userID
  );

  Map<String, dynamic> toMap() {
    return {
      'dictionaryId': dictionaryID,
      'dictionaryName': dictionaryName,
      'description': description,
      'rating': rating,
      'dailyVisit': dailyVisit,
      'dictionarySettingsId': dictionarySettingsID,
      'folderId': folderID,
      'userId': userID,
    };
  }

  factory Dictionary.fromMap(Map<String, dynamic> map) {
    return Dictionary(
      map['dictionaryId'],
      map['dictionaryName'],
      map['description'],
      map['rating'],
      map['dailyVisit'],
      map['dictionarySettingsId'],
      map['folderId'],
      map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dictionary.fromJson(String source) => Dictionary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Dictionary(dictionaryID: $dictionaryID, dictionaryName: $dictionaryName, description: $description, rating: $rating, dailyVisit: $dailyVisit, dictionarySettingsID: $dictionarySettingsID, folderID: $folderID, userID: $userID)';
  }
}
