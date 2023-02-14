import 'package:flutter/material.dart';
import 'package:stuartappclone/data/services/auth_services.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/custom_check_box_validator.dart';
import 'package:stuartappclone/screens/widgets/custom_text_field_validator.dart';
import '../constants/constants.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:stuartappclone/screens/widgets/build_textfield.dart';
import 'package:stuartappclone/screens/widgets/custom_check_tile.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _conPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _termsAndCondNotif = ValueNotifier<bool>(false);

  final ValueNotifier<bool> _privacyPolicyNotif = ValueNotifier<bool>(false);


  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        backgroundColor: getPeachColor,
        appBar: getLeadingOnlyAppBar(context: context),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: SingleChildScrollView(
            key: const Key("signupList"),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldValidator(
                    textEditingController: _firstNameController,
                    label: "First name",
                    marginVertPad: 5.0,
                    showSuffixWidget: false,
                    validator: (val) => _nameValidator(
                        _firstNameController , "Name is too short"
                    ),
                  ),
                  CustomTextFieldValidator(
                    textEditingController : _lastNameController,
                    label: "Last name",
                    marginVertPad: 5.0,
                    validator: (val) => _nameValidator(
                        _lastNameController , "Last name is too short"
                    ),
                  ),
                  CustomTextFieldValidator(
                    textEditingController : _emailController,
                    label: "Email",
                    marginVertPad: 5.0,
                    validator: _emailValidator,
                  ),
                  CustomTextFieldValidator(
                      textEditingController: _passwordController,
                      validator: (val) => _passwordValidator(),
                      label: "Password",
                      marginVertPad: 5.0,
                      textFieldEnum: ValidatorTextFieldEnum.password
                  ),
                  CustomTextFieldValidator(
                    textEditingController: _conPasswordController,
                    validator: (val) => _passwordValidator(
                        confirmPass: true
                    ),
                    label: "Confirm password",
                    marginVertPad: 5.0,
                    textFieldEnum: ValidatorTextFieldEnum.password,
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: _termsAndCondNotif,
                      builder: (context, isChecked, child){
                        return CustomCheckBoxValidator(
                          onPressed: (){
                            _termsAndCondNotif.value = !_termsAndCondNotif.value;
                          },
                          validator: (val) => _termsAndCondCheckBoxValidator(
                              _termsAndCondNotif.value
                          ),
                          isChecked: isChecked,
                          hyperLinkContent: "Terms & Condtions",
                          hyperLink: "",
                        );
                      }
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: _privacyPolicyNotif,
                      builder: (context, isChecked, child){
                        return CustomCheckBoxValidator(
                          onPressed: (){
                            _privacyPolicyNotif.value = !_privacyPolicyNotif.value;
                          },
                          validator: (val) =>  _privacyPolicyCheckBoxValidator(
                              _privacyPolicyNotif.value
                          ),
                          isChecked: isChecked,
                          hyperLinkContent: "Privacy policy",
                          hyperLink: "",
                        );
                      }
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BuildButton(
                        buttonName: "Sign up",
                        marginVertPad: 5.0,
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            await AuthService().signUpWithEmailAndPassWord(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _firstNameController.text
                                    + " " + _lastNameController.text
                            );

                            Navigator.pushNamed(
                                context, RouteNames.authWrapperScreen
                            );
                          }
                        }
                    ),
                  ),
                  authOrText,
                  loginGoogleButton(
                      context: context,
                      content: "Sign in with Google",
                      onPressed: (dialogContext) async{
                        await AuthService().signUpWithGoogle().then((userCredential){
                          Navigator.pushNamed(context, RouteNames.authWrapperScreen);
                        });
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _nameValidator(
    TextEditingController controller, String errorText
  ){
    return controller.text.isEmpty
      ? "This field cannot be empty"
      :  controller.text.length < 4
      ? errorText
      : null;
  }

  String? _emailValidator(String? val){
    return _emailController.text.isEmpty
      ? "This field cannot be empty"
      : (_emailController.text.length < 4
        || !_emailController.text.contains("@")
        || !_emailController.text.contains(".")
      )
      ? "Invalid email"
      : null;
  }

  String? _passwordValidator({
    bool confirmPass = false
  }){
    if(confirmPass){
      return _passwordController.text.isEmpty
        ? "This field cannot be empty"
        : (_passwordController.text != _conPasswordController.text)
        ? "Password don't match"
        : null;
    }else{
      return _passwordController.text.isEmpty
        ? "This field cannot be empty"
        : _passwordController.text.length < 5
        ? "Password is too short"
        : !_passwordController.text.contains(RegExp(r'[A-Z]'))
        ? "Atleast one uppercase letter is mandatory"
        : !_passwordController.text.contains(RegExp(r'[A-Z!@#%^&*()+=_,.?:{}|<>]+$'))
        ? "Atleast one special character !@#%^&*()+=_,.?:{}|<> is mandatory"
        : null;
    }
  }

  String? _termsAndCondCheckBoxValidator(bool val) => val
      ? null
      : "Please review and accept our Terms and Conditions";

  String? _privacyPolicyCheckBoxValidator(bool val) => val
      ? null
      : "Please review and accept our Privacy policy";

}
