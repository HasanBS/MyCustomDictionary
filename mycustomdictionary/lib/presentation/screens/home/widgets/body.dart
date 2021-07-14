import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/home_strings.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Note.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/search_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/components/word_button.dart';
import 'package:mycustomdictionary/presentation/screens/folder/Dictionary/dictionary_screen.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/dictionary_field.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/note_field.dart';
import 'package:mycustomdictionary/presentation/screens/home/widgets/user_field.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/size_config.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  //const Body({ Key? key }) : super(key: key);

  String _searchValue = "##########";

  List<Dictionary> _dicList = [];

  List<Word> _wordList = [];
  List<Word> _randomWords = [];

  List<Note> _noteList = [];

  List<User> _userList = [];
  int userID = Session.activeUser!.userID;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchNoMatching) {
          _dicList = [];
          _wordList = [];
          _noteList = [];
          _userList = [];
        } else if (state is SearchLoadSuccess) {
          _dicList = state.searchList[0] as List<Dictionary>;
          _wordList = state.searchList[1] as List<Word>;
          _noteList = state.searchList[2] as List<Note>;
          _userList = state.searchList[3] as List<User>;

          _wordList.removeWhere((element) {
            int dicID = element.dictionaryID;
            Iterable<Dictionary> _ownDics =
                _dicList.where((element) => element.userID == userID);
            return _ownDics.any((element) => element.dictionaryID == dicID);
          }); //* it's remove words what in _dicList also own
          _dicList.removeWhere((element) => element.userID == userID);
          _noteList.removeWhere((element) => element.userID == userID);
          _userList.removeWhere((element) => element.userID == userID);
        } else if (state is GetRandomWordsSuccess) {
          _randomWords = state.randomWords;
        }
      },
      child: buildHome(context),
    );
  }

  SafeArea buildHome(BuildContext context) {
    SizeConfig().init(context);
    context.read<SearchCubit>().getRandomWords();
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(20)),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return HomeHeader(callback: (val) {
                if (val == "") {
                  _searchValue = "##########";
                  context.read<SearchCubit>().emit(SearchInitial());
                } else {
                  _searchValue = val;
                  context.read<SearchCubit>().search(_searchValue);
                }
              });
            },
          ),
          SizedBox(height: getProportionateScreenWidth(20)),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadSuccess) {
                return searchList(context);
              } else if (state is SearchNoMatching) {
                return searchList(context);
              } else if (state is SearchLoadState) {
                return Container(); //Center(child: CircularProgressIndicator());
              } else if (state is GetRandomWordsSuccess) {
                return randomWords(context);
              } else {
                return Container();
              }
            },
          ),
          // Dic Results
        ],
      ),
    ));
  }

  Container randomWords(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(5)), //10 mu olsa acaba?
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(5),
          vertical: getProportionateScreenWidth(15)),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text(HomeStrings.randomWords),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          if (_randomWords.length == 0) Text(HomeStrings.noWordFound),
          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _randomWords.length >= 3 ? 3 : _randomWords.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return WordButton(
                  editOn: false,
                  word: _randomWords[index],
                  onPressed: () {
                    // Navigator.pushNamed(context, WordScreen.routeName,
                    //     arguments: snapshot.data[i]);
                    Navigator.of(context)
                        .pushNamed("/word", arguments: _randomWords[index]);
                  },
                );
              }),
        ],
      ),
    );
  }

  Container searchList(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text(HomeStrings.dictionaries),
              Expanded(
                child: Divider(),
              ),
            ],
          ),

          if (_dicList.length == 0) Text(HomeStrings.noDictionaryFound),

          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _dicList.length >= 3 ? 3 : _dicList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return DictionaryField(
                  dictionary: _dicList[index],
                  description: _dicList[index].description,
                  dictionaryName: _dicList[index].dictionaryName,
                  //dictionaryID: _dicList[index].dictionaryID,
                  press: () {
                    Navigator.of(context)
                        .pushNamed("/dictionary", arguments: _dicList[index]);
                  },
                );
              }),

          if (_dicList.length > 3)
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/list", arguments: _dicList);
                },
                child: Text(HomeStrings.allMatchingDictionaries)),
          // Word Results
          SizedBox(height: getProportionateScreenWidth(20)),
          Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text(HomeStrings.words),
              Expanded(
                child: Divider(),
              ),
            ],
          ),

          if (_wordList.length == 0) Text(HomeStrings.noWordFound),

          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _wordList.length >= 3 ? 3 : _wordList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return WordButton(
                  editOn: false,
                  word: _wordList[index],
                  onPressed: () {
                    // Navigator.pushNamed(context, WordScreen.routeName,
                    //     arguments: snapshot.data[i]);
                    Navigator.of(context)
                        .pushNamed("/word", arguments: _wordList[index]);
                  },
                );
              }),

          if (_wordList.length > 3)
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/list", arguments: _wordList);
                }, // pushNamed with argument snapshot.data1
                child: Text(HomeStrings.allMatchingWords)),
          // Note Results
          SizedBox(height: getProportionateScreenWidth(20)),
          Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text(HomeStrings.notes),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          if (_noteList.length == 0) Text(HomeStrings.noNoteFound),

          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _noteList.length >= 3 ? 3 : _noteList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return NoteField(
                  description: _noteList[index].details,
                  noteName: _noteList[index].title,
                  press: () {
                    Navigator.of(context)
                        .pushNamed("/note", arguments: _noteList[index]);
                  },
                );
              }),

          if (_noteList.length > 3)
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/list", arguments: _noteList);
                }, // pushNamed with argument snapshot.data2
                child: Text(HomeStrings.allMatchingNotes)),
          // User Results
          SizedBox(height: getProportionateScreenWidth(20)),
          Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text(HomeStrings.users),
              Expanded(
                child: Divider(),
              ),
            ],
          ),

          if (_userList.length == 0) Text(HomeStrings.noUserFound),

          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _userList.length >= 3 ? 3 : _userList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return UserField(
                  press: () {
                    Navigator.of(context)
                        .pushNamed("/user", arguments: _userList[index]);
                  },
                  user: _userList[index],
                );
              }),

          if (_userList.length > 3)
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/list", arguments: _userList);
                }, // pushNamed with argument snapshot.data3
                child: Text(HomeStrings.allMatchingUsers)),
        ],
      ),
    );
  }
}
