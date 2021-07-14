import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/LoginModel.dart';
import 'package:mycustomdictionary/data/models/LoginResultModel.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/session.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordContoller;
  final GlobalKey<FormState> formKey;

  bool isLoginFail = false;
  bool isLoading = false;

  LoginCubit(this.emailController, this.passwordContoller, this.formKey)
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final loginResult = await ApiConnection.login(
          new LoginModel(emailController.text, passwordContoller.text));
      if (loginResult == null) {
        isLoginFail = true;
        LoginValidateState(isLoginFail);
        emit(LoginValidateState(isLoginFail));
        changeLoadingView();
        emit(LoginError("Login is not succesfull"));
      } else if (loginResult is LoginResultModel) {
        await _sessionCreate(loginResult);
      }
    }
  }

  //Future<void> cechePostUserModel() async {}

  Future<void> _sessionCreate(LoginResultModel loginResult) async {
    Session.activeUser = new User(
        loginResult.userID,
        loginResult.name,
        loginResult.surname,
        loginResult.username,
        loginResult.mail,
        loginResult.profileID,
        loginResult.rootFolderID,
        loginResult.notificationSettingsID);
    Session.token = "Bearer " + loginResult.token;
    Session.mainFolder =
        await ApiConnection.getFolder(loginResult.rootFolderID);
    Session.profile = await ApiConnection.getProfile(loginResult.profileID);
    Session.notifications =
        await ApiConnection.getNotificationsByUser(Session.activeUser!.userID);
    changeLoadingView();

    emit(LoginComplete(loginResult));
  }

//TODO: useri splash screen karsilayacak cache bellekte session kayitli ise oradan homescreene yollayacak
//TODO: session yoksa welcome screen yada login folder ve profil altindaki yapilar cache bellekte yadedilecek
//TODO: offlineiken yapilan herhangi degisiklikte folderda user publish dediginde profilde ise bir session boolean ile internet oldugunda guncelleme yapilacak
//TODO: logout cache bellegi silecek

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}
