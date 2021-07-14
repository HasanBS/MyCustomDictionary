import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/popup_cubit.dart';

import 'custom_rect_tween.dart';

class EditPopupCard extends StatelessWidget {
  final data;
  final String heroTodo;
  //GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  EditPopupCard({
    Key? key,
    required this.data,
    required this.heroTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setControllers();
    return BlocProvider(
      create: (context) => PopupCubit(
        //_formKey,
        _titleController,
        _descriptionController,
        heroTodo,
      ),
      child: BlocConsumer<PopupCubit, PopupState>(
        listener: (context, state) {
          if (state is EditPopupComplete && heroTodo == "Edit-Dic") {
            context.read<DictionaryCubit>().emit(EditDictionaryState());
            Navigator.pop(context);
          } else if (state is EditPopupComplete && heroTodo == "Edit-Folder") {
            context.read<FolderCubit>().emit(EditFolderState());
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return buildCenter(context, state);
        },
      ),
    );
  }

  void setControllers() {
    if (data is Folder) {
      _titleController.text = data.folderName;
      _descriptionController.text = data.description;
      //_titleController = new TextEditingController(text: data.folderName);
      //_descriptionController =
      //new TextEditingController(text: data.description);
    } else if (data is Dictionary) {
      _titleController.text = data.dictionaryName;
      _descriptionController.text = data.description;
      //_titleController = new TextEditingController(text: data.dictionaryName);
      //_descriptionController =
      //    new TextEditingController(text: data.description);
    }
  }

  Center buildCenter(BuildContext context, PopupState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Hero(
          tag: heroTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: AppTheme.lightPrimaryLightColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  //key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) => (value ?? '').length > 0
                            ? null
                            : FolderStrings.enterTitle,
                        //textt
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              25), //Caracter limit for popup
                        ],
                        decoration: InputDecoration(
                          hintText:
                              FolderStrings.title,//* with a if statement we can add name of the object in text with hero parameter
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) => (value ?? '').length > 0
                            ? null
                            : FolderStrings.enterDescription,
                        //textt
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(
                        //       25), //Caracter limit for popup
                        // ],

                        decoration: InputDecoration(
                          hintText:
                              FolderStrings.description, //* with a if statement we can add name of the object in text with hero parameter
                          border: InputBorder.none,
                        ),
                        maxLines: 6,
                        cursorColor: Colors.white,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PopupCubit>().editPopupCard(data);
                        },
                        child: Text(FolderStrings.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
