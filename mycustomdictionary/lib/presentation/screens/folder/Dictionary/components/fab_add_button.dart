import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/dictionary_strings.dart';
import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/Popup/create_popup_card.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/Popup/hero_dialog_route.dart';

class FabAddButton extends StatelessWidget {
  final int dictionaryID;
  FabAddButton(this.dictionaryID);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Color(0xFF0AAAF7), shape: BoxShape.circle),
      width: 60,
      height: 60,
      child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          enableFeedback: true,
          onPressed: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (_) {
              return BlocProvider.value(
                  value: BlocProvider.of<WordCubit>(context),
                  child: CreatePopupCard(
                    heroAddTodo: 'Create-Word',
                    folderID: dictionaryID, // Dictionary Id
                    nameHintText: DictionaryStrings
                        .word, //Folder id for set the root of the create
                  ));
            }));
            // create word
            // Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            //   return CreatePopupCard(
            //     heroAddTodo: 'Create-Word',
            //     folderID: dictionaryID, // Dictionary Id
            //     nameHintText: "Word", //Folder id for set the root of the create
            //   );
            // }));

            // Navigator.pushNamed(context, WordScreen.routeName);
          }),
    );
  }
}
