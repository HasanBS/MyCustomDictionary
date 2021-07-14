import 'dart:convert';

class Note {
  int noteID;
  String title;
  String details;
  bool isPrivate;
  int folderID;
  int userID;
  
  Note(
    this.noteID,
    this.title,
    this.details,
    this.isPrivate,
    this.folderID,
    this.userID,
  );

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteID,
      'title': title,
      'details': details,
      'isPrivate': isPrivate,
      'folderId': folderID,
      'userId': userID,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      map['noteId'],
      map['title'],
      map['details'],
      map['isPrivate'],
      map['folderId'],
      map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(noteID: $noteID, title: $title, details: $details, isPrivate: $isPrivate, folderID: $folderID, userID: $userID)';
  }
}
