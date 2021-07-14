import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';

import 'Popup/custom_rect_tween.dart';
import 'Popup/edit_popup_card.dart';
import 'Popup/hero_dialog_route.dart';

class FolderField extends StatelessWidget {
  final String description, folderName;
  final int folderID;
  final VoidCallback press;
  final Folder? folder;

  const FolderField(
      {Key? key,
      required this.press,
      required this.description,
      required this.folderName,
      required this.folderID,
      this.folder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderCubit, FolderState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Slidable(
              actionPane: SlidableScrollActionPane(),
              actionExtentRatio: 0.15,
              actions: [
                Hero(
                  tag: 'Edit-Folder',
                  createRectTween: (begin, end) {
                    return CustomRectTween(begin: begin!, end: end!);
                  },
                  child: Container(
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
                              // Navigator.of(context)
                              //     .push(HeroDialogRoute(builder: (context) {
                              //   return EditPopupCard(
                              //       data: folder, heroTodo: 'Edit-Folder');
                              // }));

                              Navigator.of(context).push(HeroDialogRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<FolderCubit>(
                                            context),
                                        child: EditPopupCard(
                                            data: folder,
                                            heroTodo: 'Edit-Folder'),
                                      )));
                            },
                          ))),
                ),
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
                                          FolderStrings.folderDeleteConfirm),
                                      content: Text(
                                          FolderStrings.folderDeleteWarning),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(FolderStrings.yes),
                                          onPressed: () {
                                            //delete operation
                                            context
                                                .read<FolderCubit>()
                                                .deleteFolder(folderID);
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
                        Icons.folder_open,
                        color: AppTheme.lightPrimaryColor,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              folderName,
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Color(0xFFADCBFF),
                    padding: EdgeInsets.all(20), //button kalinlik
                  )),
            ));
      },
    );
  }
}
