import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/edit_profile_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/ProfileScreenData.dart';
import 'package:mycustomdictionary/logic/cubit/profile_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_button.dart';

class EditTextField extends StatelessWidget {
  final ProfileScreenData screenData;

  late final TextEditingController _controllerName;
  late final TextEditingController _controllerDescription;
  late final TextEditingController _controllerSurname;

  EditTextField({Key? key, required this.screenData}) : super(key: key);

  Widget build(BuildContext context) {
    _controllerName = new TextEditingController(text: screenData.user.name);
    _controllerDescription =
        new TextEditingController(text: screenData.profile.description);
    _controllerSurname =
        new TextEditingController(text: screenData.user.surname);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: _controllerName,
                onChanged: (value) {},
                maxLines: 1,
                maxLength: 40, // isim karakter siniri
                decoration: InputDecoration(
                  hintText: EditProfileStrings.profieName,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              TextField(
                controller: _controllerSurname,
                onChanged: (value) {},
                maxLines: 1,
                maxLength: 40, // isim karakter siniri
                decoration: InputDecoration(
                  hintText: EditProfileStrings.profileSurname,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              TextField(
                controller: _controllerDescription,
                onChanged: (value) {},
                maxLines: 4,
                maxLength: 200, // isim karakter siniri
                decoration: InputDecoration(
                  hintText: EditProfileStrings.profileDescription,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              RoundedButton(
                text: EditProfileStrings.saveChanges,
                press: () async {
                  context.read<ProfileCubit>().updateProfile(
                      _controllerName.text,
                      _controllerSurname.text,
                      _controllerDescription.text);
                  Navigator.pop(context);
                },
                color: AppTheme.lightPrimaryColor,
              )
            ],
          ),
        );
      },
    );
  }
}
