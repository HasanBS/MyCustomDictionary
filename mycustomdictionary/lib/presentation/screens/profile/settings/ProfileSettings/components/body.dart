import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/profile_settings_strings.dart';
import 'package:mycustomdictionary/data/models/ProfileSettings.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ProfileSettings settings;
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProfileSettingsState) {
          settings = state.profileSettings;
          return ListView(
            children: [
              ListTile(
                title: Text(ProfileSettingsStrings.hideProfile),
                trailing: Switch(
                  value: settings.hideProfile,
                  onChanged: (bool value) {
                    setState(() {
                      settings.hideProfile = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(ProfileSettingsStrings.hideProfilePicture),
                trailing: Switch(
                  value: settings.hideProfilePicture,
                  onChanged: settings.hideProfile
                      ? null
                      : (bool value) {
                          setState(() {
                            settings.hideProfilePicture = value;
                          });
                        },
                ),
                enabled: !settings.hideProfile,
              ),
              ListTile(
                title: Text(ProfileSettingsStrings.hideName),
                trailing: Switch(
                  value: settings.hideName,
                  onChanged: settings.hideProfile
                      ? null
                      : (bool value) {
                          setState(() {
                            settings.hideName = value;
                          });
                        },
                ),
                enabled: !settings.hideProfile,
              ),
              ListTile(
                minVerticalPadding: 30,
                trailing: ElevatedButton(
                  child: Text(ProfileSettingsStrings.save),
                  onPressed: () {
                    context.read<SettingsCubit>().editProfileSettings(settings);
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
