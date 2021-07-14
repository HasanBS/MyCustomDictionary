import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomdictionary/core/constants/strings/welcome_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_button.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // this size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              WelcomeStrings.welcomeToMCD,
              style: TextStyle(fontWeight: FontWeight.bold), //text style
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SvgPicture.asset(
              "assets/icons/dictionaryV2.svg",
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: WelcomeStrings.login,
              color: AppTheme.lightPrimaryColor,
              press: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
            RoundedButton(
              text: WelcomeStrings.signin,
              color: AppTheme.lightPrimaryColor,
              press: () {
                Navigator.of(context).pushNamed('/signup');
              },
            )
          ],
        ),
      ),
    );
  }
}
