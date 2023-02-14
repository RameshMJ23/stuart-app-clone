import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stuartappclone/data/services/auth_services.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/widgets/custom_text_field_validator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';

import '../route/routes_names.dart';

class AuthScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _enableLoginButton = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return NoInternetScreenBuilder(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getPeachColor,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 50.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Stuart Ev",
                      style: textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Charge your car effortlessly",
                      style: textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFieldValidator(
                            textFieldKey: const Key("authEmailField"),
                            textEditingController: _emailController,
                            validator: _emailValidator,
                            label: "Email",
                            marginVertPad: 0.0,
                            constantValidation: true,
                            onChanged: (val){_checkEnablingLogin(); },
                          ),
                          const SizedBox(height: 10.0,),
                          CustomTextFieldValidator(
                            textFieldKey: const Key("authPasswordField"),
                            textEditingController: _passwordController,
                            validator: _passwordValidator,
                            label: "Password",
                            marginVertPad: 0.0,
                            showSuffixWidget: true,
                            constantValidation: true,
                            textFieldEnum: ValidatorTextFieldEnum.password,
                            onChanged: (val){ _checkEnablingLogin(); },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _enableLoginButton,
                      builder: (context, enableButton, child){
                        return BuildButton(
                          key: const Key("authLoginKey"),
                          buttonName: "Login",
                          onPressed: enableButton
                            ? () {
                              showLoadingDialog(
                                context: context,
                                dialogFunc: (dialogContext) async{
                                  await AuthService().signInWithEmailAndPassWord(
                                    email: _emailController.text,
                                    password: _passwordController.text
                                  ).then((user){
                                    if(user != null){
                                      Navigator.pop(dialogContext);
                                      Navigator.pushReplacementNamed(
                                        context, RouteNames.authWrapperScreen
                                      );
                                    }else{
                                      Navigator.pop(dialogContext);
                                      showErrorDialog(
                                        context: context,
                                        title: "Authentication error",
                                        content: "Incorrect email, password, or both"
                                      );
                                    }
                                  });
                                }
                              );
                            } : null,
                          disableColor: getVioletColor.withOpacity(0.3),
                          marginVertPad: 8.0,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BuildButton.transparent(
                      key: const Key("authForgotPassKey"),
                      buttonName: "Forgot Password?",
                      onPressed: () async{
                        await launchUrl(Uri.parse(
                          "https://web.stuart.energy/forgot-password"
                        ));
                      },
                      marginVertPad: 5.0
                    ),
                  ),
                  //const Spacer(),
                  authOrText,
                  loginGoogleButton(
                      context: context,
                      content: "Log in with Google",
                      onPressed: (dialogContext) async{

                        await AuthService().signInWithGoogle().then((user){
                          Navigator.pop(dialogContext);
                          if(user != null){
                            Navigator.pushNamed(
                                context, RouteNames.homeScreen
                            );
                          }
                        });

                      }
                  ),
                  const SizedBox(height: 8.0,),
                  BuildButton.custom(
                    customButtonIcon: Icons.arrow_forward_ios,
                    customButtonText: "Don't have an account",
                    onPressed: (){
                      Navigator.pushNamed(context, RouteNames.signUpScreen);
                    },
                    splashColor: getVioletColor.withOpacity(0.4),
                    iconSize: 15.0,
                  )
                ],
              ),
            )
        ),
      )
    );
  }

  _checkEnablingLogin(){
    if(_emailButtonValidator() && _passwordButtonValidator()){
      _enableLoginButton.value = true;
    }else{
      _enableLoginButton.value = false;
    }
  }

  bool _emailButtonValidator(){
    if(_emailController.text.length > 3){
      if(!_emailController.text.contains("@")
          || !_emailController.text.contains(".")
      ){
        return false;
      }else{
        return true;
      }
    }

    return false;
  }

  bool _passwordButtonValidator(){
    if (_passwordController.text.length > 4){
      return true;
    }else{
      return false;
    }
  }

  String? _emailValidator(String? val){
    if((_emailController.text.length > 3)){
      if(!_emailController.text.contains("@")
          || !_emailController.text.contains(".")
      ){
        return "Invalid email";
      }else{
        return null;
      }
    }

    return null;
  }

  String? _passwordValidator(String? val){
    return (_passwordController.text.length < 5
      && _passwordController.text.length > 3)
      ? "Password is too short"
      :  null;
  }
}
