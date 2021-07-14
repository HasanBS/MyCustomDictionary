import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';

import 'Folder.dart';
import 'Notification.dart';
import 'Profile.dart';
import 'User.dart';

//TODO: sessionu cache bellege kaydet
//TODO: update booleani olustur
//TODO: internet baglantisina bakaraktan update yap

class Session {
  static User? activeUser;
  static Folder? mainFolder;
  static Profile? profile;
  static List<Notification>? notifications;
  static String? token;

  static void updateNotifications() async {
    Session.notifications =
        await ApiConnection.getNotificationsByUser(Session.activeUser!.userID);
  }
}
