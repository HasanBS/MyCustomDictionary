import 'dart:convert';

class Comment {
  int commentID;
  String commentDate;
  String commentText;
  bool isLiked;
  int dictionaryID;
  int senderID;

  Comment(
    this.commentID, 
    this.commentDate, 
    this.commentText, 
    this.isLiked,
    this.dictionaryID, 
    this.senderID
  );

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentID,
      'commentDate': commentDate,
      'commentText': commentText,
      'isLiked': isLiked,
      'dictionaryId': dictionaryID,
      'senderId': senderID,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      map['commentId'],
      map['commentDate'],
      map['commentText'],
      map['isLiked'],
      map['dictionaryId'],
      map['senderId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commentID: $commentID, commentDate: $commentDate, commentText: $commentText, isLiked: $isLiked, dictionaryID: $dictionaryID, senderID: $senderID)';
  }
}
