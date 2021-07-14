import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/dictionary_screen.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Note/note_screen.dart';

import '../folder_screen.dart';
import 'Popup/hero_dialog_route.dart';
import 'dictionary_field.dart';
import 'folder_field.dart';
import 'note_field.dart';

class Body extends StatelessWidget {
  final Folder folder;

  const Body({Key? key, required this.folder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildSingleChildScrollView(context);
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    //, FolderState state
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 20),
        BlocConsumer<FolderCubit, FolderState>(
          listener: (context, state) {
            if (state is NewFolderState) {
              Navigator.pop(context);
              context.read<FolderCubit>().getFolders();
            }
            if (state is DeleteFolderState || state is EditFolderState) {
              context.read<FolderCubit>().getFolders();
            }
          },
          builder: (context, state) {
            return BlocBuilder<FolderCubit, FolderState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state is FolderLoadSuccess)
                      for (var folder in state.folders)
                        FolderField(
                            press: () async {
                              Navigator.of(context)
                                  .pushNamed('/folder', arguments: folder);
                            },
                            folder: folder,
                            folderID: folder.folderID,
                            description: folder.description,
                            folderName: folder.folderName),
                  ],
                );
              },
            );
          },
        ),
        BlocConsumer<DictionaryCubit, DictionaryState>(
          listener: (context, state) {
            if (state is NewDictionaryState) {
              Navigator.pop(context);
              context.read<DictionaryCubit>().getDictionary(folder);
            }
            if (state is DeleteDictionaryState ||
                state is EditDictionaryState) {
              context.read<DictionaryCubit>().getDictionary(folder);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                if (state is DictionaryLoadSuccess)
                  for (var dictionary in state.dictonaries)
                    DictionaryField(
                      press: () async {
                        //TODO: Get Words
                        Navigator.of(context)
                            .pushNamed('/dictionary', arguments: dictionary);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => BlocProvider.value(
                        //           value:
                        //               BlocProvider.of<DictionaryCubit>(context),
                        //           child: DictionaryScreen(
                        //             dictionary: dictionary,
                        //           ),
                        //         )));
                      },
                      dictionary: dictionary,
                      description: dictionary.description,
                      dictionaryName: dictionary.dictionaryName,
                      dictionaryID: dictionary.dictionaryID,
                    ),
              ],
            );
          },
        ),
        BlocConsumer<NoteCubit, NoteState>(
          listener: (context, state) {
            if (state is NoteUpdateState) {
              context.read<NoteCubit>().getNotes();
            }
            if (state is NewNoteState) {
              Navigator.pop(context);
              context.read<NoteCubit>().getNotes();
            }
            if (state is DeleteNoteState) context.read<NoteCubit>().getNotes();
          },
          builder: (context, state) {
            return Column(
              children: [
                if (state is NoteLoadSuccess)
                  for (var note in state.notes)
                    NoteField(
                        press: () async {
                          // Navigator.of(context)
                          //     .pushNamed('/note', arguments: note);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<NoteCubit>(context),
                                    child: NoteScreen(
                                      note: note,
                                      readOnly: false,
                                    ),
                                  )));
                        },
                        noteID: note.noteID,
                        description: note.details,
                        noteName: note.title)
              ],
            );
          },
        )
      ],
    ));
  }
}
