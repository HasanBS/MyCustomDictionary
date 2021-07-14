import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';

part 'popup_state.dart';

class PopupCubit extends Cubit<PopupState> {
  //final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String heroTodo;

  bool isLoading = false;
  bool isEditFail = false;

  PopupCubit(this.titleController, this.descriptionController,
      this.heroTodo) //this.formKey,
      : super(PopupInitial());

  Future<void> editPopupCard(dynamic data) async {
    //if (formKey.currentState != null && formKey.currentState!.validate()) {
    changeLoadingView();

    if (heroTodo == "Edit-Dic" && data is Dictionary) {
      data.dictionaryName = titleController.text;
      data.description = descriptionController.text;
      final response = await ApiConnection.editDictionary(data);
      if (response.statusCode == 200 || response.statusCode == 204) {
        changeLoadingView();
        emit(EditPopupComplete());
      } else {
        isEditFail = true;
        emit(PopupValidateState(isEditFail));
        changeLoadingView();
        emit(EditPopupError("Edit Dictionary is not succesfull"));
      }
    } else if (heroTodo == "Edit-Folder" && data is Folder) {
      data.folderName = titleController.text;
      data.description = descriptionController.text;
      final response = await ApiConnection.editFolder(data);
      if (response.statusCode == 200 || response.statusCode == 204) {
        changeLoadingView();
        emit(EditPopupComplete());
      } else {
        isEditFail = true;
        emit(PopupValidateState(isEditFail));
        changeLoadingView();
        emit(EditPopupError("Edit Folder is not succesfull"));
      }
    }
    //}
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(PopupLoadingState(isLoading));
  }
}
