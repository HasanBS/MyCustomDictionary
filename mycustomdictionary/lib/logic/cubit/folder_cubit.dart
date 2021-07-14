import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/Note.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  final Folder _folder;

  bool isUpdated = false;
  bool isLoading = false;
//  bool isDeleted = false;

  FolderCubit(this._folder) : super(FolderInitial());

  Future<void> getFolders() async {
    //changeLoadingModel();
    final folders = (await ApiConnection.getChildFolders(_folder.folderID));
    if (folders is List<Folder>) {
      print('Folder');
      emit(FolderLoadSuccess(folders));
    }
    //changeLoadingModel();
  }

  Future<void> newFolder(int folderID, String title, String decription) async {
    final response =
        await ApiConnection.createFolder(folderID, title, decription);
    if (response is Folder) {
      emit(NewFolderState());
    }
  }

  Future<void> deleteFolder(int folderID) async {
    final response = await ApiConnection.deleteFolder(folderID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      //isDeleted = true;
      emit(DeleteFolderState());
    }
  }

  void changeLoadingModel() {
    isLoading = !isLoading;
    emit(FolderLoadingState(isLoading));
  }
}
