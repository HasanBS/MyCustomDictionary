import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/LoginModel.dart';
import 'package:mycustomdictionary/data/models/LoginResultModel.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/Notification.dart';
import 'package:mycustomdictionary/data/models/NotificationSettings.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/ProfileSettings.dart';
import 'package:mycustomdictionary/data/models/SignupModel.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/data/models/session.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

main(List<String> args) {
  HttpOverrides.global = new MyHttpOverrides();
  var result = ApiConnection.dictionaryFollowCheck(2, 3);
  result.then((value) => print(value));
}

class ApiConnection {
  static String host = 'http://customdict-001-site1.dtempurl.com';
  // 'http://10.0.2.2:58725'
  // 'http://192.168.2.100:201'
  // 'http://customdict-001-site1.dtempurl.com'
  static Future<List<Folder>> getAllFoldersFromApi() async {
    var uri = Uri.parse(host + "/folders");
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var folderList = jsonDecode(response.body) as List;
    List<Folder> folders = folderList.map((e) => Folder.fromMap(e)).toList();

    return folders;
  }

  static Future<List<Folder>> getChildFolders(int parentFolderID) async {
    var uri = Uri.parse(
        host + '/folders/getChildFolders/' + parentFolderID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var folderList = jsonDecode(response.body) as List;
    List<Folder> folders = folderList.map((e) => Folder.fromMap(e)).toList();
    return folders;
  }

  static Future<http.Response> deleteWord(int wordID) async {
    var uri = Uri.parse(host + '/words/deleteWord/' + wordID.toString());
    final response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<http.Response> deleteNote(int noteID) async {
    var uri = Uri.parse(host + '/notes/deleteNote/' + noteID.toString());
    final response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<http.Response> deleteDictionary(int dictionaryID) async {
    var uri = Uri.parse(
        host + '/dictionaries/deleteDictionary/' + dictionaryID.toString());
    final response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    return response;
  }

  static Future<http.Response> deleteFolder(int folderID) async {
    var uri = Uri.parse(host + '/folders/deleteFolder/' + folderID.toString());
    final response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    return response;
  }

  static Future<List<Dictionary>> getFollowedDictionaries(int userID) async {
    var uri =
        Uri.parse(host + '/users/getFollowedDictionaries/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var dictionaryList = jsonDecode(response.body) as List;
    List<Dictionary> dictionaries =
        dictionaryList.map((e) => Dictionary.fromMap(e)).toList();

    return dictionaries;
  }

  static Future<List<Dictionary>> searchDictionary(
      String dictionaryName) async {
    var uri = Uri.parse(host + '/dictionaries/searchDictionary');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: jsonEncode({'dictionaryName': dictionaryName}));

    var dictionaryList = jsonDecode(response.body) as List;
    List<Dictionary> dictionaries =
        dictionaryList.map((e) => Dictionary.fromMap(e)).toList();

    return dictionaries;
  }

  static Future<List<User>> searchUsers(String userName) async {
    var uri = Uri.parse(host + '/users/searchUser');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: jsonEncode({'userName': userName}));

    var userList = jsonDecode(response.body) as List;
    List<User> users = userList.map((e) => User.fromMap(e)).toList();

    return users;
  }

  static Future<List<User>> getFollowers(int userID) async {
    var uri = Uri.parse(host + '/users/getFollowers/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var userList = jsonDecode(response.body) as List;
    List<User> users = userList.map((e) => User.fromMap(e)).toList();

    return users;
  }

  static Future<List<User>> getFollowedUsers(int userID) async {
    var uri = Uri.parse(host + '/users/getFollowedUsers/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var userList = jsonDecode(response.body) as List;
    List<User> users = userList.map((e) => User.fromMap(e)).toList();

    return users;
  }

  static Future<List<Note>> searchNotes(String noteTitle) async {
    var uri = Uri.parse(host + '/notes/searchNote');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: jsonEncode({'noteTitle': noteTitle}));

    var noteList = jsonDecode(response.body) as List;
    List<Note> notes = noteList.map((e) => Note.fromMap(e)).toList();

    return notes;
  }

  static Future<List<Word>> searchWord(String word) async {
    var uri = Uri.parse(host + '/words/searchWord');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: jsonEncode({'wordName': word}));

    var wordList = jsonDecode(response.body) as List;
    List<Word> words = wordList.map((e) => Word.fromMap(e)).toList();

    return words;
  }

  static Future<List<Dictionary>> getDictionariesByUser(int userID) async {
    var uri = Uri.parse(
        host + '/dictionaries/getDictionariesByUser/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var dictionaryList = jsonDecode(response.body) as List;
    List<Dictionary> dictionaries =
        dictionaryList.map((e) => Dictionary.fromMap(e)).toList();

    return dictionaries;
  }

  static Future<List<Dictionary>> getDictionariesByFolder(int folderID) async {
    var uri = Uri.parse(
        host + '/dictionaries/getDictionariesByFolder/' + folderID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var dictionaryList = jsonDecode(response.body) as List;
    List<Dictionary> dictionaries =
        dictionaryList.map((e) => Dictionary.fromMap(e)).toList();

    return dictionaries;
  }

  static Future<List<Note>> getNotesByFolder(int folderID) async {
    var uri =
        Uri.parse(host + '/notes/getNotesByFolder/' + folderID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var noteList = jsonDecode(response.body) as List;
    List<Note> notes = noteList.map((e) => Note.fromMap(e)).toList();

    return notes;
  }

  static Future<List<Note>> getNotesByUser(int userID) async {
    var uri = Uri.parse(host + '/notes/getNotesByUser/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var noteList = jsonDecode(response.body) as List;
    List<Note> notes = noteList.map((e) => Note.fromMap(e)).toList();

    return notes;
  }

  static Future<List<Notification>> getNotificationsByUser(int userID) async {
    var uri = Uri.parse(
        host + '/notifications/getNotificationsByUser/' + userID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var notifList = jsonDecode(response.body) as List;
    List<Notification> notifications =
        notifList.map((e) => Notification.fromMap(e)).toList();

    return notifications;
  }

  static Future<List<Word>> getWordsByDictionary(int dictionaryID) async {
    var uri = Uri.parse(
        host + '/words/getWordsByDictionary/' + dictionaryID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });

    var wordList = jsonDecode(response.body) as List;
    List<Word> words = wordList.map((e) => Word.fromMap(e)).toList();

    return words;
  }

  static Future<List<Word>> getRandomWords(int wordCount) async {
    var uri = Uri.parse(
        host + '/words/getRandomWords/' + wordCount.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    var wordList = jsonDecode(response.body) as List;
    List<Word> words = wordList.map((e) => Word.fromMap(e)).toList();

    return words;
  }

  static Future<Folder?> getFolder(int folderID) async {
    var uri = Uri.parse(host + '/folders/' + folderID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Authorization": Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      Folder folder = Folder.fromJson(response.body);
      return folder;
    }
  }

  static Future<Profile?> getProfile(int profileID) async {
    var uri = Uri.parse(host + '/profiles/' + profileID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      Profile profile = Profile.fromJson(response.body);
      return profile;
    }
  }

  static Future<ProfileSettings?> getProfileSettings(
      int profileSettingsID) async {
    var uri =
        Uri.parse(host + '/profilesettings/' + profileSettingsID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      ProfileSettings profileSettings = ProfileSettings.fromJson(response.body);
      return profileSettings;
    }
  }

  static Future<NotificationSettings?> getNotificationSettings(
      int notificationSettingsID) async {
    var uri = Uri.parse(
        host + '/notificationsettings/' + notificationSettingsID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      NotificationSettings notificationSettings =
          NotificationSettings.fromJson(response.body);
      return notificationSettings;
    }
  }

  static Future<Note?> getNote(int noteID) async {
    var uri = Uri.parse(host + '/notes/' + noteID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      Note note = Note.fromJson(response.body);
      return note;
    }
  }

  static Future<Dictionary?> getDictionary(int dictionaryID) async {
    var uri = Uri.parse(host + '/dictionaries/' + dictionaryID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if (response.statusCode == 404) {
      return null;
    } else {
      Dictionary dictionary = Dictionary.fromJson(response.body);
      return dictionary;
    }
  }

  static Future<LoginResultModel?> login(LoginModel loginInfo) async {
    var uri = Uri.parse(host + '/users/login');
    var response = await http.post(uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: loginInfo.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      LoginResultModel loginResult = LoginResultModel.fromJson(response.body);
      return loginResult;
    }
  }

  static Future<Folder?> createFolder(
      int parentFolderID, String name, String description) async {
    Folder folder = new Folder(
        0, name, description, parentFolderID); //, Session.activeUser!.userID
    var uri = Uri.parse(host + '/folders/createFolder');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: folder.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      return folder;
    }
  }

  static Future<Word?> createWord(
      int dictionaryID, String word, String description, String details) async {
    Word newWord = new Word(0, word, description, details, dictionaryID);
    var uri = Uri.parse(host + '/words/createWord');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: newWord.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      return newWord;
    }
  }

  static Future<Dictionary?> createDictionary(
      int parentFolderID, String name, String description) async {
    Dictionary dictionary = new Dictionary(0, name, description, 3, 0, 1,
        parentFolderID, Session.activeUser!.userID);
    var uri = Uri.parse(host + '/dictionaries/createDictionary');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: dictionary.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      return dictionary;
    }
  }

  static Future<Note?> createNote(
      int parentFolderID, String name, String description) async {
    Note note = new Note(0, name, description, false, parentFolderID,
        Session.activeUser!.userID);
    var uri = Uri.parse(host + '/notes/createNote');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: note.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      return note;
    }
  }

  static Future<http.Response> followUser(int userID, int followerID) async {
    var uri = Uri.parse(host +
        '/userfollows/followUser/' +
        userID.toString() +
        "/" +
        followerID.toString());
    final response = await http.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<http.Response> unfollowUser(int userID, int followerID) async {
    var uri = Uri.parse(host +
        '/userfollows/unfollowUser/' +
        userID.toString() +
        "/" +
        followerID.toString());
    var response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<http.Response> followDictionary(int userID, int dictionaryID) async {
    var uri = Uri.parse(host +
        '/dictionaryfollows/followDictionary/' +
        userID.toString() +
        "/" +
        dictionaryID.toString());
    final response = await http.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<http.Response> unfollowDictionary(int userID, int dictionaryID) async {
    var uri = Uri.parse(host +
        '/dictionaryfollows/unfollowDictionary/' +
        userID.toString() +
        "/" +
        dictionaryID.toString());
    var response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

    static Future<bool> dictionaryFollowCheck(int userID, int dictionaryID) async {
    var uri = Uri.parse(host +
        '/dictionaryfollows/isFollowing/' +
        userID.toString() +
        "/" +
        dictionaryID.toString());
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  static Future<http.Response> editWord(Word word) async {
    var uri = Uri.parse(host + '/words/editWord/' + word.wordID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: word.toJson());
    return responce;
  }

  static Future<http.Response> editFolder(Folder folder) async {
    var uri =
        Uri.parse(host + '/folders/editFolder/' + folder.folderID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: folder.toJson());
    return responce;
  }

  static Future<http.Response> editDictionary(Dictionary dictionary) async {
    var uri = Uri.parse(host +
        '/dictionaries/editDictionary/' +
        dictionary.dictionaryID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: dictionary.toJson());
    return responce;
  }

  static Future<http.Response> editProfile(Profile profile) async {
    var uri = Uri.parse(
        host + '/profiles/editProfile/' + profile.profileID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: profile.toJson());
    return responce;
  }

  static Future<http.Response> editUser(User user) async {
    var uri = Uri.parse(host + '/users/editUser/' + user.userID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: user.toJson());
    return responce;
  }

  static Future<http.Response> editNote(Note note) async {
    var uri = Uri.parse(host + '/notes/editNote/' + note.noteID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: note.toJson());

    return responce;
  }

  static Future<http.Response> editProfileSettings(
      ProfileSettings profileSettings) async {
    var uri = Uri.parse(host +
        '/profilesettings/editProfileSettings/' +
        profileSettings.profileSettingsID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: profileSettings.toJson());

    return responce;
  }

  static Future<http.Response> editNotificationSettings(
      NotificationSettings notificationSettings) async {
    var uri = Uri.parse(host +
        '/notificationsettings/EditNotificationSettings/' +
        notificationSettings.notificationSettingsID.toString());
    final responce = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: Session.token!
        },
        body: notificationSettings.toJson());
    return responce;
  }

  static Future<http.Response> deleteNotification(int notificationID) async {
    var uri = Uri.parse(host + '/notifications/deleteNotification/' + notificationID.toString());
    final response = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: Session.token!
    });
    return response;
  }

  static Future<User?> signUp(SignupModel user) async {
    var uri = Uri.parse(host + '/users/createUser');
    var response = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: user.toJson());
    if (response.statusCode == 404) {
      return null;
    } else {
      User newUser = User.fromJson(response.body);
      return newUser;
    }
  }
}
