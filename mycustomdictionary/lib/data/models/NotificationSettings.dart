import 'dart:convert';

class NotificationSettings {
  int notificationSettingsID;
  bool notifications;
  bool newDictionary;
  bool newNote;
  bool newWord;
  bool newComment;

  NotificationSettings(
    this.notificationSettingsID,
    this.notifications,
    this.newDictionary,
    this.newNote,
    this.newWord,
    this.newComment,
  );

  Map<String, dynamic> toMap() {
    return {
      'notificationSettingsId': notificationSettingsID,
      'notifications': notifications,
      'newDictionary': newDictionary,
      'newNote': newNote,
      'newWord': newWord,
      'newComment': newComment,
    };
  }

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      map['notificationSettingsId'],
      map['notifications'],
      map['newDictionary'],
      map['newNote'],
      map['newWord'],
      map['newComment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationSettings.fromJson(String source) => NotificationSettings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationSettings(notificationSettingsID: $notificationSettingsID, notifications: $notifications, newDictionary: $newDictionary, newNote: $newNote, newWord: $newWord, newComment: $newComment)';
  }
}
