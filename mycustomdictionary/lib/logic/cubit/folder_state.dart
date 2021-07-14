part of 'folder_cubit.dart';

abstract class FolderState {}

class FolderInitial extends FolderState {}

class FolderLoadInProgress extends FolderState {}

class FolderLoadSuccess extends FolderState {
  FolderLoadSuccess(this.folders);
  final List<Folder> folders;
}

class FolderUpdate extends FolderState {
  FolderUpdate(this.update);
  final bool update;
}

class FolderLoadingState extends FolderState {
  final bool isLoading;
  FolderLoadingState(this.isLoading);
}

class NewFolderState extends FolderState {}

class EditFolderState extends FolderState {}

class DeleteFolderState extends FolderState {}
