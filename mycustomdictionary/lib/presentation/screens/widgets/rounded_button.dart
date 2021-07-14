import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
            style: ElevatedButton.styleFrom(
              primary: color,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            )),
      ),
    );
  }
}
