import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final VoidCallback press;

  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 22,
                color: AppTheme.lightPrimaryColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
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
            primary: Color(0xFFF5F6F9),
            padding: EdgeInsets.all(20), //button kalinlik
          )),
    );
  }
}
