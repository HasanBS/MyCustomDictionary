import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';

class NoteField extends StatelessWidget {
  final String description, noteName;
  final int? rating, noteID;
  final VoidCallback press;

  const NoteField({
    Key? key,
    required this.press,
    required this.description,
    required this.noteName,
    this.rating,
    this.noteID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: noteID is int
          ? BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                return buildSlidable(context);
              },
            )
          : buildSlidable(context),
    );
  }

  Slidable buildSlidable(BuildContext context) {
    return Slidable(
      enabled: noteID is int ? true : false,
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.15,
      actions: [
        // Container(
        //     margin: EdgeInsets.symmetric(vertical: 10),
        //     child: ClipRRect(
        //         //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //         //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        //         borderRadius: BorderRadius.circular(30),
        //         child: IconSlideAction(
        //           caption: 'Edit',
        //           color: Colors.white,
        //           foregroundColor: Colors.blue,
        //           icon: Icons.archive,
        //           onTap: () => () {},
        //         ))),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: IconSlideAction(
                  caption: FolderStrings.delete,
                  color: Colors.white,
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => CupertinoAlertDialog(
                              title: Text(FolderStrings.noteDeleteConfirm),
                              // content: Text(
                              //     "Every Word In This Dictionary Will Be Delete!"),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(FolderStrings.yes),
                                  onPressed: () {
                                    //delete operation
                                    context
                                        .read<NoteCubit>()
                                        .deleteNote(noteID!);
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(FolderStrings.no),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                ))),
      ],
      child: ElevatedButton(
          onPressed: press,
          child: Row(
            children: [
              Icon(
                Icons.note_rounded,
                color: AppTheme.lightPrimaryColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      noteName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: Color(0xFFFDDBB0),
            padding: EdgeInsets.all(20), //button kalinlik
          )),
    );
  }
}
