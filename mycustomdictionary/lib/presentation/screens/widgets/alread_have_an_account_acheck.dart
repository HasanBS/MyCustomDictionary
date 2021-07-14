import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/widgets_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function()? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login
              ? WidgetsStrings.dontHaveAccount
              : WidgetsStrings.alreadyHavAccount,
          style: TextStyle(color: AppTheme.lightPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? WidgetsStrings.signup : WidgetsStrings.signin,
            style: TextStyle(
                color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
