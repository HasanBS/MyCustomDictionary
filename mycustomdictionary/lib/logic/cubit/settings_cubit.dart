import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/NotificationSettings.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/ProfileSettings.dart';
import 'package:mycustomdictionary/data/models/session.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> getNotificationSettings() async {
    print("selammm");
    final notificationSettings = await ApiConnection.getNotificationSettings(
        Session.activeUser!.notificationSettingsID);
    print(notificationSettings);
    if (notificationSettings is NotificationSettings) {
      print("Get noti settings");
      emit(NotificationSettingsState(notificationSettings));
    }
  }

  Future<void> editNotificationSettings(NotificationSettings settings) async {
    final responce = await ApiConnection.editNotificationSettings(settings);
    if (responce.statusCode == 200 || responce.statusCode == 204) {
      print("Edit Noti settings");
    }
  }

  Future<void> getProfileSettings(Profile profile) async {
    final profileSettings =
        await ApiConnection.getProfileSettings(profile.profileSettingsID);
    if (profileSettings is ProfileSettings) {
      emit(ProfileSettingsState(profileSettings));
    }
  }

  Future<void> editProfileSettings(ProfileSettings settings) async {
    final responce = await ApiConnection.editProfileSettings(settings);
    if (responce.statusCode == 200 || responce.statusCode == 204) {
      print("Edit Profile settings");
    }
  }
}
