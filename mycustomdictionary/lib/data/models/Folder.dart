import 'dart:convert';

import 'package:mycustomdictionary/logic/product/base_model.dart';

class Folder extends IBaseModel {
  int folderID;
  String folderName;
  String description;
  int parentFolderID;
  //int userID;

  Folder(
    this.folderID,
    this.folderName,
    this.description,
    this.parentFolderID,
    //this.userID,
  );
  @override
  Map<String, dynamic> toMap() {
    return {
      'folderId': folderID,
      'folderName': folderName,
      'description': description,
      'parentFolderId': parentFolderID,
      //'userId': userID,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      map['folderId'],
      map['folderName'],
      map['description'],
      map['parentFolderId'],
      //map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) => Folder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Folder(folderID: $folderID, folderName: $folderName, description: $description, parentFolderID: $parentFolderID)'; //, userId: $userID
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}
