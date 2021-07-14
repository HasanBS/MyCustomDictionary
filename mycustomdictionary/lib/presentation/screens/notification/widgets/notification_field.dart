import 'package:flutter/material.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Notification.dart' as Ntf;
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';

class NotificationField extends StatelessWidget {
  final Ntf.Notification notification;
  NotificationField({Key? key, required this.notification}) : super(key: key);

  Widget notificationBox(String notificationText, String notificationDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Dismissible(
        onDismissed: (direction) async {
          await ApiConnection.deleteNotification(notification.notificationID);
        },
        key: ObjectKey(notification.notificationID),
        direction: DismissDirection.startToEnd,
        background: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            child: Icon(Icons.delete),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10)), //10 mu olsa acaba?
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(15)),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF4A3298),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text.rich(
            TextSpan(
              text: notificationDate,
              style: TextStyle(
                color: Colors.white,
              ),
              children: [
                TextSpan(
                    text: notificationText,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return notificationBox(notification.text, notification.date + "\n");
  }
}
