import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/notification_settings_strings.dart';
import 'package:mycustomdictionary/data/models/NotificationSettings.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late NotificationSettings settings;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        //context.read<SettingsCubit>().getNotificationSettings();
        if (state is NotificationSettingsState) {
          settings = state.notificationSettings;
          return ListView(
            children: [
              ListTile(
                title: Text(NotificationSettingsStrings.notifications),
                trailing: Switch(
                  value: settings.notifications,
                  onChanged: (bool value) {
                    setState(() {
                      settings.notifications = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(NotificationSettingsStrings.newNote),
                trailing: Switch(
                  value: settings.newNote,
                  onChanged: !settings.notifications
                      ? null
                      : (bool value) {
                          setState(() {
                            settings.newNote = value;
                          });
                        },
                ),
                enabled: settings.notifications,
              ),
              ListTile(
                title: Text(NotificationSettingsStrings.newDictionary),
                trailing: Switch(
                  value: settings.newDictionary,
                  onChanged: !settings.notifications
                      ? null
                      : (bool value) {
                          setState(() {
                            settings.newDictionary = value;
                          });
                        },
                ),
                enabled: settings.notifications,
              ),
              // ListTile(
              //   title: Text("New Word"),
              //   trailing: Switch(
              //     value: settings.newWord,
              //     onChanged: !settings.notifications?null:(bool value) {
              //       setState(() {
              //         settings.newWord = value;
              //       });
              //     },
              //   ),
              //   enabled: settings.notifications,
              // ),
              /*ListTile(
                title: Text(NotificationSettingsStrings.newComment),
                trailing: Switch(
                  value: settings.newComment,
                  onChanged: !settings.notifications
                      ? null
                      : (bool value) {
                          setState(() {
                            settings.newComment = value;
                          });
                        },
                ),
                enabled: settings.notifications,
              ),*/
              ListTile(
                minVerticalPadding: 30,
                trailing: ElevatedButton(
                  child: Text(NotificationSettingsStrings.save),
                  onPressed: () {
                    context
                        .read<SettingsCubit>()
                        .editNotificationSettings(settings);
                  },
                ),
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }
}
