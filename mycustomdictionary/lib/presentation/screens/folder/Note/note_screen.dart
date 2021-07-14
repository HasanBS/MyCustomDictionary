import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Note/components/body.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

class NoteScreen extends StatelessWidget {
  final Note note;
  final bool readOnly;
  const NoteScreen({Key? key, required this.note, required this.readOnly})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/note/"+note.noteID.toString();
    if (readOnly)
      return Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Body(
          note: note,
          readOnly: readOnly,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.home,
        ),
      );
    else
      return BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(note.title),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<NoteCubit>().updateNote(note);
                    },
                    child: state is NoteLoadingState
                        ? (state.isLoading
                            ? Icon(Icons.timer)
                            : Icon(Icons.save_alt_rounded))
                        : Icon(Icons.save_alt_rounded),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        primary: AppTheme.lightPrimaryColor),
                  ),
                )
              ],
            ),
            body: Body(note: note, readOnly: readOnly),
            bottomNavigationBar: CustomBottomNavBar(
              selectedMenu: MenuState.folder,
            ),
          );
        },
      );
  }
}
