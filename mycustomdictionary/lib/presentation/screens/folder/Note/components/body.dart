import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/note_strings.dart';
import 'package:mycustomdictionary/data/models/Note.dart';

class Body extends StatelessWidget {
  final Note note;
  final bool readOnly;
  Body({Key? key, required this.note, required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerTittle =
        new TextEditingController(text: note.title);
    TextEditingController _controllerDetails =
        new TextEditingController(text: note.details);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            child: TextField(
              readOnly: readOnly,
              controller: _controllerTittle,
              onChanged: (value) {
                note.title = value;
              },
              maxLines: 1,
              decoration: InputDecoration(
                hintText: NoteStrings.title,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: TextField(
                readOnly: readOnly,
                controller: _controllerDetails,
                onChanged: (value) {
                  note.details = value;
                },
                maxLines: 100,
                keyboardType: TextInputType.multiline,
                //maxLength: 10, karakter sayisini limitleme
                decoration: InputDecoration(
                  hintText: NoteStrings.details,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
