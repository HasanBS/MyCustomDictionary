import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/User.dart';

class UserField extends StatelessWidget {
  final User user;
  final VoidCallback press;

  const UserField({
    Key? key,
    required this.press,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
          onPressed: press,
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: AppTheme.lightPrimaryColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      user.name + " " + user.surname,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: AppTheme.lightPrimaryUserColor,
            padding: EdgeInsets.all(20), //button kalinlik
          )),
    );
  }
}
