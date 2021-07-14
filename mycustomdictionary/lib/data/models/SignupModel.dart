import 'dart:convert';

class SignupModel {
  int? userID;
  String name;
  String surname;
  String username;
  String password;
  String mail;
  int? profileID;
  int? rootFolderID;
  int? notificationSettingsID;
  SignupModel(
    this.name,
    this.surname,
    this.username,
    this.password,
    this.mail,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'mail': mail,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      map['name'],
      map['surname'],
      map['username'],
      map['password'],
      map['mail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignupModel(name: $name, surname: $surname,username: $username, password: $password, mail: $mail)';
  }
}
