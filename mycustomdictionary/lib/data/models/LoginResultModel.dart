import 'dart:convert';

class LoginResultModel {
  int userID;
  String name;
  String surname;
  String username;
  String mail;
  int profileID;
  int rootFolderID;
  int notificationSettingsID;
  String token;

  LoginResultModel(
      this.userID,
      this.name,
      this.surname,
      this.username,
      this.mail,
      this.profileID,
      this.rootFolderID,
      this.notificationSettingsID,
      this.token);

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
      'token': token
    };
  }

  factory LoginResultModel.fromMap(Map<String, dynamic> map) {
    return LoginResultModel(
        map['userId'],
        map['name'],
        map['surname'],
        map['username'],
        map['mail'],
        map['profileId'],
        map['rootFolderId'],
        map['notificationSettingsId'],
        map['token']);
  }

  String toJson() => json.encode(toMap());

  factory LoginResultModel.fromJson(String source) =>
      LoginResultModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userID: $userID, name: $name, surname: $surname ,username: $username, mail: $mail, profileID: $profileID, rootFolderID: $rootFolderID, notificationSettingsID: $notificationSettingsID, Token $token)';
  }
}
