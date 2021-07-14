import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/Word/word_screen.dart';

import 'word_button.dart';

class Body extends StatelessWidget {
  final Dictionary dictionary;

  const Body({Key? key, required this.dictionary}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordCubit, WordState>(
      listener: (context, state) {
        if (state is WordUpdateState) {
          context.read<WordCubit>().getWords();
        }
        if (state is NewWordState) {
          Navigator.pop(context);
          context.read<WordCubit>().getWords();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //TODO: var note in state.notes
                if (state is WordLoadSuccess)
                  for (var word in state.words)
                    WordButton(
                      editOn: dictionary.userID == Session.activeUser!.userID,
                      item: word.wordID,
                      word: word,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<WordCubit>(context),
                                  child: WordScreen(
                                    word: word,
                                    readOnly: dictionary.userID !=
                                        Session.activeUser!.userID,
                                  ),
                                )));

                        // Navigator.pushNamed(context, WordScreen.routeName,
                        //         arguments: words[i])
                      },
                      onDismissed: (direction) {
                        context.read<WordCubit>().deleteWord(word.wordID);
                        //direction shows the swipe position but we have one
                        //position and its for delete
                        //delete the word we have
                      },
                      //TODO: Circularprogress
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
