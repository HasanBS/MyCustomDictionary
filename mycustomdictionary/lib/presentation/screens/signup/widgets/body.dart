import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/signup_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/logic/cubit/signup_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/alread_have_an_account_acheck.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/or_divider.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_button.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_input_field.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_password_field.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/social_icon.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameContoller = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(nameController, surnameContoller,
          usernameController, passwordContoller, emailContoller, _formKey),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(SignupStrings.signupSuccessful)));
            state.navigate(context);
            //} else if (context.watch<SignupCubit>().isSignupFail) {
          } else if (BlocProvider.of<SignupCubit>(context, listen: false)
              .isSignupFail) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(SignupStrings.signupFail)));
          }
        },
        builder: (context, state) {
          return buildBackGround(context, state);
        },
      ),
    );
  }

  BackGround buildBackGround(BuildContext context, SignupState state) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: Stack(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: autovalidateMode(state),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    SignupStrings.signup,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: SignupStrings.name,
                    fieldContoller: nameController,
                    validator: (value) => (value ?? '').length > 3
                        ? null
                        : SignupStrings.nameLengthError,
                  ),
                  RoundedInputField(
                    hintText: SignupStrings.surname,
                    fieldContoller: surnameContoller,
                    validator: (value) => (value ?? '').length > 3
                        ? null
                        : SignupStrings.surnameLengthError,
                  ),
                  RoundedInputField(
                    hintText: SignupStrings.username,
                    fieldContoller: usernameController,
                    validator: (value) => (value ?? '').length > 3
                        ? null
                        : SignupStrings.usernameLengthError,
                  ),
                  RoundedInputField(
                    hintText: SignupStrings.email,
                    fieldContoller: emailContoller,
                    validator: (value) =>
                        (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!))
                            ? null
                            : SignupStrings.emailValidError,
                  ),
                  RoundedPasswordField(
                    passwordContoller: passwordContoller,
                    validator: (value) => (value ?? '').length > 3
                        ? null
                        : SignupStrings.passwordLengthError,
                  ),
                  RoundedButton(
                    text: SignupStrings.signup,
                    color: AppTheme.lightPrimaryColor,
                    press: () async {
                      BlocProvider.of<SignupCubit>(context, listen: false)
                          .signUser();
                      //context.read<SignupCubit>().signUser();
                    },
                  ),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                  OrDiviger(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/icons/google-plus.svg",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible:
                BlocProvider.of<SignupCubit>(context, listen: false).isLoading,
            //visible :context.watch<SignupCubit>().isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AutovalidateMode autovalidateMode(SignupState state) => state
          is SignupValidateState
      ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
      : AutovalidateMode.disabled;
}

extension SignCompleteExtension on SignupComplete {
  void navigate(BuildContext context) {
    Navigator.of(context).pushNamed('/login');
  }
}
