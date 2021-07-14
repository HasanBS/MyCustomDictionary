import 'package:flutter/material.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/presentation/screens/notification/notification_screen.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  final callback;

  const HomeHeader({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, //rowlar arasina splacce ekleme
        children: [
          SearchField(
            callback: callback,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: (Session.notifications != null)
                ? Session.notifications!.length
                : 0, // notification sayisi
            press: () {
              Navigator.of(context).pushNamed("/notifications");
              /*Navigator.push(
                context,
                
                new MaterialPageRoute(
                  builder: (context) => new NotificationScreen(),
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }
}
