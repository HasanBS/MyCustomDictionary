import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/SignupModel.dart';
import 'package:mycustomdictionary/data/models/User.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final TextEditingController nameController;
  final TextEditingController surnameContoller;
  final TextEditingController usernameController;
  final TextEditingController passwordContoller;
  final TextEditingController emailContoller;
  final GlobalKey<FormState> formKey;

  bool isSignupFail = false;
  bool isLoading = false;

  SignupCubit(
    this.nameController,
    this.surnameContoller,
    this.usernameController,
    this.passwordContoller,
    this.emailContoller,
    this.formKey,
  ) : super(SignupInitial());

  void signUser() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      print(true);
      changeLoadingView();
      final signupResult = await ApiConnection.signUp(new SignupModel(
        nameController.text,
        surnameContoller.text,
        usernameController.text,
        passwordContoller.text,
        emailContoller.text,
      ));
      print(signupResult);
      if (signupResult == null) {
        isSignupFail = true;
        SignupValidateState(isSignupFail);
        emit(SignupValidateState(isSignupFail));
      } else {
        emit(SignupComplete(signupResult));
      }
      // if(signupResult != null){
      //   Navigator.push(
      //     context,
      //     new MaterialPageRoute(
      //       builder: (context) => new HomeScreen(),
      //     ),
      //   );
      // }
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(SignupLoadingState(isLoading));
  }
}
