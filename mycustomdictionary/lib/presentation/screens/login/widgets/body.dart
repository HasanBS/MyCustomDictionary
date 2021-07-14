import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomdictionary/core/constants/strings/login_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/logic/cubit/login_cubit.dart';
import 'package:mycustomdictionary/logic/product/cache_manager.dart';
import 'package:mycustomdictionary/presentation/screens/home/home_screen.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/alread_have_an_account_acheck.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_button.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_input_field.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/rounded_password_field.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(
              emailContoller,
              passwordContoller,
              _formKey,
            ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginComplete) {
              CacheManager.instance.addCacheItem(
                  '${state.loginResultModel.userID}', state.loginResultModel);
              state.navigate(context);
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return buildBackground(context, state);
          },
        ));
  }

  Background buildBackground(BuildContext context, LoginState state) {
    Size size = MediaQuery.of(context).size;
    return Background(
      // duruma gore safeArea kullanilabilir
      child: Stack(children: [
        Form(
          key: _formKey,
          autovalidateMode: autovalidateMode(state),
          // this is for wrong enter user name or password
          child: SingleChildScrollView(
            //Overflow pixel icin SingleChildScrollView widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  LoginStrings.login,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: size.height * 0.03), //aralara bosluk atmak icin
                SvgPicture.asset(
                  "assets/icons/dictionaryV2.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.02),
                RoundedInputField(
                  hintText: LoginStrings.usernameOrEmail,
                  fieldContoller: emailContoller,
                  validator: (value) => (value ?? '').length > 3
                      ? null
                      : LoginStrings.userLengthError,
                ),
                RoundedPasswordField(
                  passwordContoller: passwordContoller,
                  validator: (value) => (value ?? '').length > 3
                      ? null
                      : LoginStrings.passwordLengthError,
                ),
                RoundedButton(
                  text: LoginStrings.login,
                  color: AppTheme.lightPrimaryColor,
                  press: () {
                    context.read<LoginCubit>().postUserModel();
                  },
                ),
                SizedBox(height: size.height * 0.02),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: context.watch<LoginCubit>().isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ]),
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) => state
          is LoginValidateState
      ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
      : AutovalidateMode.disabled;
}

extension LoginCompleteExtension on LoginComplete {
  void navigate(BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }
}
