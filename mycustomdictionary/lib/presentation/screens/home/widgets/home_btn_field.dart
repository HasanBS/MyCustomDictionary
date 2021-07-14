import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/home_strings.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';

class HomeBtnField extends StatelessWidget {
  const HomeBtnField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20)), //10 mu olsa acaba?
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
          text: HomeStrings.homeBtnFieldLastDictionary,
          style: TextStyle(
            color: Colors.white,
          ),
          children: [
            TextSpan(
                text: HomeStrings.homeBtnFieldLastWord,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
