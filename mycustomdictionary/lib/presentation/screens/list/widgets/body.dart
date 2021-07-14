import 'package:flutter/material.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/components/word_button.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/dictionary_field.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/folder_field.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/note_field.dart';
import 'package:mycustomdictionary/presentation/screens/home/widgets/user_field.dart';

class Body extends StatelessWidget {
  final List<dynamic> data;
  const Body({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (data[index] is Dictionary)
            return DictionaryField(
              press: () {
                Navigator.of(context)
                    .pushNamed('/dictionary', arguments: data[index]);
              },
              description: data[index].description,
              dictionaryName: data[index].dictionaryName,
            );
          else if (data[index] is Note)
            return NoteField(
                press: () {
                  Navigator.of(context)
                      .pushNamed('/note', arguments: data[index]);
                },
                description: data[index].details,
                noteName: data[index].title);
          else if (data[index] is Word)
            return WordButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/word", arguments: data[index]);
              },
              word: data[index],
              editOn: false,
            );
          else if (data[index] is User)
            return UserField(
              press: () {
                Navigator.of(context)
                    .pushNamed("/user", arguments: data[index]);
              },
              user: data[index],
            );
          else
            return Container();
        });
  }
}
