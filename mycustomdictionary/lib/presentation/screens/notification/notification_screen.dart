import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/notifications_strings.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';

import 'widgets/body.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";

  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/notifications";
    return Scaffold(
        appBar: AppBar(
          title: Text(NotificationsStrings.title),
        ),
        body: Body());
  }
}
