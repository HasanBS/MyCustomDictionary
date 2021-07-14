import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';
import 'custom_rect_tween.dart';
import 'pstyles.dart';

bool _selection = true;

//!
//TODO implement cubit for all the actions
class CreatePopupCard extends StatefulWidget {
  final String heroAddTodo;
  final int folderID;
  final String nameHintText;

  CreatePopupCard({
    Key? key,
    required this.heroAddTodo,
    required this.folderID,
    required this.nameHintText,
  }) : super(key: key);

  @override
  _CreatePopupCardState createState() => _CreatePopupCardState();
}

class _CreatePopupCardState extends State<CreatePopupCard> {
  String? _description;
  String? _title;
  //final GlobalKey<FormState> _formKey = GlobalKey(); //? not working for now
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Color choseColor(String hero) {
    if (hero == 'Create-Dic') {
      return AppColors.accentColor;
    } else if (hero == 'Create-Folder') {
      return AppColors.accentColorFolder;
    } else if (hero == 'Create-Note') {
      return AppColors.accentColorNote;
    } else if (hero == 'Create-Word') {
      return AppColors.accentColorWord;
    } else {
      return AppColors.accentColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Hero(
          tag: widget.heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: choseColor(widget.heroAddTodo),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  //key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              //height: 20,
                              child: TextFormField(
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
                                  hintText: widget.nameHintText,
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white,
                                onChanged: (value) {
                                  _title = value.trim();
                                },
                              ),
                            ),
                          ),
                          if (widget.heroAddTodo == "Create-Dic")
                            ToggleButtons(
                              children: [
                                Icon(Icons.book),
                                Icon(Icons.language),
                              ],
                              selectedColor: Colors.purple,
                              renderBorder: true,
                              borderRadius: BorderRadius.circular(30),
                              borderWidth: 2,
                              isSelected: [_selection, !_selection],
                              onPressed: (index) {
                                setState(() {
                                  _selection = !_selection;
                                });
                              },
                            )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) => (value ?? '').length > 0
                            ? null
                            : FolderStrings.enterDescription,
                        //text
                        decoration: InputDecoration(
                          hintText: FolderStrings.description,
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                        onChanged: (value) {
                          _description = value.trim();
                        },
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            //butona basildiginda word yada description yazilip yazilmadigini kontrol eden bir if lazim
                            //bos birakilan yerler icinde toest mesaj yazilabilir
                            // if (_formKey.currentState != null &&
                            //     _formKey.currentState!.validate()) {}
                            if (widget.heroAddTodo == 'Create-Folder')
                              context.read<FolderCubit>().newFolder(
                                  widget.folderID,
                                  (_title ?? ''),
                                  (_description ?? ''));
                            else if (widget.heroAddTodo == 'Create-Dic')
                              context.read<DictionaryCubit>().newDictionary(
                                  widget.folderID,
                                  (_title ?? ''),
                                  (_description ?? ''));
                            else if (widget.heroAddTodo == 'Create-Note')
                              context.read<NoteCubit>().newNote(widget.folderID,
                                  (_title ?? ''), (_description ?? ''));
                            else if (widget.heroAddTodo == 'Create-Word')
                              context.read<WordCubit>().newWord(widget.folderID,
                                  (_title ?? ''), (_description ?? ''), "");
                            //! Title and decription need validation check this is important
                          },
                          child: Text(FolderStrings.add),
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.lightPrimaryWordAddButtonColor,
                            padding: EdgeInsets.symmetric(),
                          ),
                        ),
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
