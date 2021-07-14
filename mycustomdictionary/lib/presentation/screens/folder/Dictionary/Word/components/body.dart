import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/word_strings.dart';

import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';

class Body extends StatelessWidget {
  final Word word;
  final bool readOnly;
  const Body({Key? key, required this.word, required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerWord =
        new TextEditingController(text: word.word);
    TextEditingController _controllerDescription =
        new TextEditingController(text: word.description);
    TextEditingController _controllerDetails =
        new TextEditingController(text: word.details);
    return SingleChildScrollView(
        child: Container(
      //line sayisi sabitlendi artarsa ekrana sigmama riski var scroll eklenebilir
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            child: TextField(
              readOnly: readOnly,
              controller: _controllerWord,
              onChanged: (value) {
                word.word = value;
              },
              maxLines: 1,
              decoration: InputDecoration(
                hintText: WordStrings.word,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: TextField(
              readOnly: readOnly,
              controller: _controllerDescription,
              onChanged: (value) {
                word.description = value;
              },
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              //maxLength: 10, karakter sayisini limitleme
              decoration: InputDecoration(
                hintText: WordStrings.description,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: TextField(
              readOnly: readOnly,
              controller: _controllerDetails,
              onChanged: (value) {
                word.details = value;
              },
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              //maxLength: 10, karakter sayisini limitleme
              decoration: InputDecoration(
                hintText: WordStrings.details,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
