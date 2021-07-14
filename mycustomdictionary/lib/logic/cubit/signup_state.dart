part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupComplete extends SignupState {
  final User signupResultModel;

  SignupComplete(this.signupResultModel);
}

class SignupValidateState extends SignupState {
  final bool isValidate;
  SignupValidateState(this.isValidate);
}

class SignupLoadingState extends SignupState {
  final bool isLoading;

  SignupLoadingState(this.isLoading);
}

// class SignupError extends SignupState {
//   final String message;
//   SignupError(this.message);
// }
