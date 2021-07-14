import 'package:flutter/material.dart';

class AccountDescriptionField extends StatelessWidget {
  final String nameSurname;

  final String description;

  const AccountDescriptionField({
    Key? key,
    required this.nameSurname,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(maxWidth: 400),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            nameSurname,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            description,
            maxLines: 4,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
