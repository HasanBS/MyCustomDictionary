import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/widgets_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';

class OrDiviger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              WidgetsStrings.or,
              style: TextStyle(
                  color: AppTheme.lightPrimaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9D),
        height: 1.5,
      ),
    );
  }
}
