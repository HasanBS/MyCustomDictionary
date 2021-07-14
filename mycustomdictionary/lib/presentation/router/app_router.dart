import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/exceptions/route_exception.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/Word/word_screen.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/dictionary_screen.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Note/note_screen.dart';
import 'package:mycustomdictionary/presentation/screens/folder/folder_screen.dart';
import 'package:mycustomdictionary/presentation/screens/home/home_screen.dart';
import 'package:mycustomdictionary/presentation/screens/list/list_screen.dart';
import 'package:mycustomdictionary/presentation/screens/login/login_screen.dart';
import 'package:mycustomdictionary/presentation/screens/notification/notification_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/EditProfile/edit_profile_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/profile_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/NotificationSettings/notificationsettings_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/ProfileSettings/profilesettings_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/settings_screen.dart';
import 'package:mycustomdictionary/presentation/screens/signup/signup_screen.dart';
import 'package:mycustomdictionary/presentation/screens/welcome/welcome_screen.dart';

class AppRounter {
  static const String welcomeScreen = 'welcome';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String homeScreen = '/home';
  static const String folderScreen = "/folder";
  static const String myProfileScreen = "/profile";
  static const String userProfileScreen = "/user";
  static const String noteScreen = "/note";
  static const String dictionaryScreen = "/dictionary";
  static const String wordScreen = "/word";
  static const String editProfileScreen = "/editprofile";
  static const String settingsScreen = "/settings";
  static const String notiSettingsScreen = "/notiSettings";
  static const String notificationScreen = "/notifications";
  static const String profileSettingsScreen = "/profileSettings";
  static const String listScreen = "/list";

  const AppRounter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case signupScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case folderScreen:
        return MaterialPageRoute(
          builder: (_) {
            final folder = settings.arguments as Folder;
            return FolderScreen(folder: folder);
          },
        );
      case noteScreen:
        return MaterialPageRoute(
          builder: (_) {
            final note = settings.arguments as Note;
            return NoteScreen(
              note: note,
              readOnly: true,
            );
          },
        );

      case dictionaryScreen:
        return MaterialPageRoute(
          builder: (_) {
            final dictionary = settings.arguments as Dictionary;
            return DictionaryScreen(
              dictionary: dictionary,
            );
          },
        );

      case wordScreen:
        return MaterialPageRoute(
          builder: (_) {
            final word = settings.arguments as Word;
            return WordScreen(
              word: word,
              readOnly: true,
            );
          },
        );

      case myProfileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case userProfileScreen:
        return MaterialPageRoute(builder: (_) {
          final user = settings.arguments as User;
          return ProfileScreen(
            user: user,
          );
        });

      case editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
        );

      case settingsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final profile = settings.arguments as Profile;
            return SettingsScreen(profile: profile);
          },
        );
      case notiSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => NotificationSettingsScreen(),
        );
      case notificationScreen:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
      case profileSettingsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final profile = settings.arguments as Profile;
            return ProfileSettingsScreen(profile: profile);
          },
        );
      case listScreen:
        return MaterialPageRoute(
          builder: (_) {
            final data = settings.arguments as List<dynamic>;
            return ListScreen(data: data);
          },
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
