import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';

import 'Popup/edit_popup_card.dart';
import 'Popup/hero_dialog_route.dart';

class DictionaryField extends StatelessWidget {
  final String description, dictionaryName;
  final int? rating;
  final int? dictionaryID;
  final Dictionary? dictionary;
  final VoidCallback press;

  const DictionaryField({
    Key? key,
    required this.press,
    required this.description,
    required this.dictionaryName,
    this.rating,
    this.dictionaryID,
    this.dictionary,
  }) : super(key: key);

// return BlocBuilder<DictionaryCubit, DictionaryState>(
//       builder: (context, state) {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: dictionaryID is int
          ? BlocBuilder<DictionaryCubit, DictionaryState>(
              builder: (context, state) {
                return buildSlidable(context);
              },
            )
          : buildSlidable(context),
    );
  }

  Slidable buildSlidable(BuildContext context) {
    return Slidable(
      enabled: dictionaryID is int ? true : false,
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.15,
      actions: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
                //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                borderRadius: BorderRadius.circular(30),
                child: IconSlideAction(
                  caption: FolderStrings.edit,
                  color: Colors.white,
                  foregroundColor: Colors.blue,
                  icon: Icons.archive,
                  onTap: () {
                    Navigator.of(context).push(HeroDialogRoute(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<DictionaryCubit>(context),
                              child: EditPopupCard(
                                  data: dictionary, heroTodo: 'Edit-Dic'),
                            )));
                  },
                ))),
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
                              title: Text(
                                  FolderStrings.dictionaryDeleteConfirm),
                              content: Text(
                                  FolderStrings.dictionaryDeleteWarning),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(FolderStrings.yes),
                                  onPressed: () {
                                    //delete operation
                                    context
                                        .read<DictionaryCubit>()
                                        .deleteDictionary(dictionaryID!);

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
                    // builder: (_) => AlertDialog(
                    //     title: Text(
                    //         "Do You Want To Delete This Dictionary ?"),
                    //     content: Text(
                    //         "Every Word In This Dictionary Will Be Delete!"),
                    //     actions: [
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             //delete operation is here
                    //           },
                    //           child: Text("Yes")),
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             //Close the alertdialog and do nothing
                    //           },
                    //           child: Text("No")),
                    //     ],
                    //     elevation: 40,
                    //     shape: CircleBorder()
                    //     // alertdialog modifyble
                    //     ));
                    //this cupertiondialog just for ios devices
                    //ios versioan will be use that alert dialog
                  },
                ))),
      ],
      child: ElevatedButton(
          onPressed: press,
          child: Row(
            children: [
              Icon(
                Icons.book,
                color: AppTheme.lightPrimaryColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      dictionaryName,
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
            primary: Color(0xFFf1e6ff),
            padding: EdgeInsets.all(20), //button kalinlik
          )),
    );
  }
}
