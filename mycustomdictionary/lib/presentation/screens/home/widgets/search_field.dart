import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/home_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';

class SearchField extends StatelessWidget {
  final callback;
  const SearchField({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! *
          0.7, // maybe little bit long for serch field
      height: 50,
      decoration: BoxDecoration(
        color: AppTheme.lightPrimaryLightColor.withOpacity(0.2),
        border: Border.all(color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          callback(value);
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: HomeStrings.searchFieldSearchDictionary,
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(14),
          ),
        ),
      ),
    );
  }
}
