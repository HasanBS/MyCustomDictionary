import 'package:flutter/material.dart';

class CustomNumberButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String tittle;

  final String number;

  const CustomNumberButton(
      {Key? key,
      required this.tittle,
      required this.number,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          TextButton(
              onPressed: onPressed,
              child: Text(
                number + "\n" + tittle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
                shadowColor: Colors.white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
              )),
        ],
      ),
    );
  }
}
