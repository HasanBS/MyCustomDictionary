import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/notification_settings_strings.dart';
import 'package:mycustomdictionary/logic/cubit/settings_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';
import 'components/body.dart';

class NotificationSettingsScreen extends StatelessWidget {
  //static String routeName = "/notificationSettings";

  @override
  Widget build(BuildContext context) {
    //final notificationSettings = ModalRoute.of(context).settings.arguments as NotificationSettings;
    ActivePage.route = "/notificationSettings";
    return BlocProvider(
      create: (context) => SettingsCubit()..getNotificationSettings(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(NotificationSettingsStrings.title),
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.profile,
        ),
      ),
    );
  }
}
