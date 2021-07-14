import 'package:flutter/material.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';
import 'notification_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future:
            ApiConnection.getNotificationsByUser(Session.activeUser!.userID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(20)),
                    for (var i = 0; i < snapshot.data.length; i++)
                      NotificationField(
                        notification: snapshot.data[i],
                      ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
