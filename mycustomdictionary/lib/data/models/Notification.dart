import 'dart:convert';

class Notification {
  int notificationID;
  String text;
  String title;
  String date;
  int category;


  Notification(
    this.notificationID,
    this.text,
    this.title,
    this.date,
    this.category,
  );

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationID,
      'text': text,
      'title':title,
      'date': date,
      'category': category,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      map['notificationId'],
      map['text'],
      map['title'],
      map['date'],
      map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(notificationID: $notificationID, text: $text, title: $title ,date: $date, category: $category)';
  }
}
