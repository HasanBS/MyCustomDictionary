import 'dart:convert';

class User {
  int userID;
  String name;
  String surname;
  String username;
  String mail;
  int profileID;
  int rootFolderID;
  int notificationSettingsID;
  User(
    this.userID,
    this.name,
    this.surname,
    this.username,
    this.mail,
    this.profileID,
    this.rootFolderID,
    this.notificationSettingsID,
  );


  Map<String, dynamic> toMap() {
    return {
      'userId': userID,
      'name': name,
      'surname': surname,
      'username': username,
      'mail': mail,
      'profileId': profileID,
      'rootFolderId': rootFolderID,
      'notificationSettingsId': notificationSettingsID,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['userId'],
      map['name'],
      map['surname'],
      map['username'],
      map['mail'],
      map['profileId'],
      map['rootFolderId'],
      map['notificationSettingsId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userID: $userID, name: $name, surname: $surname ,username: $username, mail: $mail, profileID: $profileID, rootFolderID: $rootFolderID, notificationSettingsID: $notificationSettingsID)';
  }
}
