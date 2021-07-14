import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final TextEditingController? fieldContoller;
  final String? Function(String?) validator;
  final ValueChanged<String>? onChanged;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.fieldContoller,
    required this.validator,
  }) : super(key: key);

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
        controller: fieldContoller,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppTheme.lightPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
