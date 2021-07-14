part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final LoginResultModel loginResultModel;

  LoginComplete(this.loginResultModel);
}

class LoginValidateState extends LoginState {
  final bool isValidate;
  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
