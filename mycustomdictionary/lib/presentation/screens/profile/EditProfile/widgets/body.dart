import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/profile_cubit.dart';

import 'edit_text_field.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(child: BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadSuccess) {
          return Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10),
              ProfilePic(
                picPath: "assets/images/profile.png",
              ),
              SizedBox(height: 10),
              EditTextField(
                  // profiledeki text bolumleri icin cekilen veriler buralara verilicek
                  screenData: state.screenData),
            ],
          );
        } else {
          return Container(); //TODOO
        }
      },
    )));
  }
}
