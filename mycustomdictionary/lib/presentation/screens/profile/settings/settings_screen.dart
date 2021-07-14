import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/settings_strings.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'widgets/body.dart';

class SettingsScreen extends StatelessWidget {
  final Profile profile;
  const SettingsScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsStrings.title),
      ),
      body: Body(profile: profile),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
