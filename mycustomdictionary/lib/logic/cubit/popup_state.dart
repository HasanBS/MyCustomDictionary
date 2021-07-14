part of 'popup_cubit.dart';

abstract class PopupState extends Equatable {
  const PopupState();

  @override
  List<Object> get props => [];
}

class PopupInitial extends PopupState {}

class PopupValidateState extends PopupState {
  final bool isValidate;
  PopupValidateState(this.isValidate);
}

class PopupLoadingState extends PopupState {
  final bool isLoading;
  PopupLoadingState(this.isLoading);
}

class EditPopupError extends PopupState {
  final String message;
  EditPopupError(this.message);
}

class EditPopupComplete extends PopupState {}
