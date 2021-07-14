import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/settings_strings.dart';

import 'package:mycustomdictionary/data/models/NotificationSettings.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/profile_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/NotificationSettings/notificationsettings_screen.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/ProfileSettings/profilesettings_screen.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  final Profile profile;
  const Body({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "assets/icons/Settings.svg",
          text: SettingsStrings.profileSettings,
          press: () async {
            // profile settingse giris yapilamiyor

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) => BlocProvider.value(
            //           value: BlocProvider.of<ProfileCubit>(context),
            //           child: ProfileSettingsScreen(),
            //         )));
            Navigator.of(context)
                .pushNamed('/profileSettings', arguments: profile);
            // ProfileSettings profileSettings =
            //     await ApiConnection.getProfileSettings(
            //         profile.profileSettingsID);
            // Navigator.pushNamed(context, ProfileSettingsScreen.routeName,
            //     arguments: profileSettings);
          },
        ),
        ProfileMenu(
          icon: "assets/icons/Bell.svg",
          text: SettingsStrings.notificationSettings,
          press: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) => BlocProvider.value(
            //           value: BlocProvider.of<SettingsCubit>(context),
            //           child: NotificationSettingsScreen(),
            //         )));
            //? noti setting only need session not profile change provider.value
            Navigator.of(context).pushNamed('/notiSettings');
            // NotificationSettings notificationSettings =
            //     await ApiConnection.getNotificationSettings(
            //         Session.activeUser.notificationSettingsID);
            // Navigator.pushNamed(context, NotificationSettingsScreen.routeName,
            //     arguments: notificationSettings);
          },
        ),
        // ProfileMenu(
        //   icon: "assets/icons/QuestionMark.svg",
        //   text: "Membership",
        //   press: () {},
        // ), //membership button for future
        ProfileMenu(
          icon: "assets/icons/QuestionMark.svg",
          text: SettingsStrings.helpCenter,
          press: () {
            print('DIY'); //TODO: HELP MEEE
          },
        ),
        ProfileMenu(
          icon: "assets/icons/LogOut.svg",
          text: SettingsStrings.logout,
          press: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => CupertinoAlertDialog(
                      title: Text(SettingsStrings.logoutConfirm),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(SettingsStrings.yes),
                          onPressed: () {
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            //TODO: Need Logout function in login cubit make the logout operations in there
                            Session.activeUser = null;
                            Session.mainFolder = null;
                            Session.notifications = null;
                            Session.profile = null;
                            Session.token = null;
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(SettingsStrings.no),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
          },
        ),
      ],
    ));
  }
}
