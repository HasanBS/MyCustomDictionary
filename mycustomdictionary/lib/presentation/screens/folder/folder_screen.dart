import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'widgets/body.dart';
import 'widgets/fab_menu.dart';

class FolderScreen extends StatelessWidget {
  final Folder folder;

  const FolderScreen({Key? key, required this.folder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/folder/" + folder.folderID.toString();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FolderCubit(folder)..getFolders(),
        ),
        BlocProvider(
          create: (context) => DictionaryCubit()..getDictionary(folder),
        ),
        BlocProvider(
          create: (context) => NoteCubit(folder)..getNotes(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(folder.folderName),
          ),
          body: Body(
            folder: folder,
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.folder,
          ),
          floatingActionButton: FabMenu(folder.folderID)),
    );
  }
}
