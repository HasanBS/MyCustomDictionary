import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/profile_settings_strings.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'components/body.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final Profile profile;
  const ProfileSettingsScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/profileSettings";
    return BlocProvider(
        create: (context) => SettingsCubit()..getProfileSettings(profile),
        child: Scaffold(
            appBar: AppBar(
              title: Text(ProfileSettingsStrings.title),
            ),
            body: Body(),
            bottomNavigationBar: CustomBottomNavBar(
              selectedMenu: MenuState.profile,
            )));
  }
}
