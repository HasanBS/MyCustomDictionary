import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/widgets_strings.dart';

import 'package:mycustomdictionary/core/themes/app_theme.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController passwordContoller;
  final String? Function(String?) validator;
  const RoundedPasswordField({
    Key? key,
    required this.passwordContoller,
    required this.validator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordField();
}

class _PasswordField extends State<RoundedPasswordField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: AppTheme.lightPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        obscureText: isHidden,
        validator: widget.validator,
        controller: widget.passwordContoller,
        decoration: InputDecoration(
          hintText: WidgetsStrings.password,
          icon: Icon(
            Icons.lock,
            color: AppTheme.lightPrimaryColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
            child: Icon(
              Icons.visibility,
              color: AppTheme.lightPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
