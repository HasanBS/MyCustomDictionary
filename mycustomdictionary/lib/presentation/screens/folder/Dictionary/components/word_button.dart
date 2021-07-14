import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/data/models/session.dart';

class WordButton extends StatelessWidget {
  final bool editOn;
  final Word word;
  final int? item;
  final VoidCallback onPressed;
  final Function(DismissDirection)? onDismissed;
  const WordButton({
    Key? key,
    required this.word,
    this.item,
    this.onDismissed,
    required this.onPressed,
    required this.editOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        confirmDismiss: (direction) async {
          return editOn;
        }, //TODO: Find better solution its looking funny
        onDismissed: onDismissed,
        key: ObjectKey(item),
        direction: DismissDirection.startToEnd,
        background: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            child: Icon(Icons.delete),
          ),
        ),
        child: ElevatedButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  Mdi.alphaABox, // wordun ilk halfine gore degisen alfabetik icon yapisi eklenebilir.
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.word,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 3),
                        Text(
                          word.description,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ]),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              primary: Color(0xFFF5F6F9),
              padding: EdgeInsets.all(15), //button kalinlik
            )),
      ),
    );
  }
}
