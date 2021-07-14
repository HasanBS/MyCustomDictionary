import 'dart:convert';

class LoginModel {
  String userName;
  String password;

  LoginModel(
    this.userName,
    this.password,
  );


  Map<String, dynamic> toMap() {
    return {
      'username': userName,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      map['username'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginModel(userName: $userName, password: $password)';
}
