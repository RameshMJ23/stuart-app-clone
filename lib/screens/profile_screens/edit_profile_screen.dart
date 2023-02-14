
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/data/services/auth_services.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:stuartappclone/screens/widgets/build_textfield.dart';
import 'package:stuartappclone/screens/widgets/custom_text_field_validator.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../constants/StuartTextStyles.dart';


class EditProfileScreen extends StatefulWidget {

  String initialName;

  String initialEmail;

  String? userImageUrl;

  EditProfileScreen({
    required this.initialName,
    required this.initialEmail,
    this.userImageUrl
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late final TextEditingController _fullNameController;

  late final TextEditingController _emailController;

  late final ValueNotifier<bool> _enableSaveButtonNotif;

  @override
  void initState() {
    // TODO: implement initState

    _fullNameController  = TextEditingController(
      text: widget.initialName
    );

    _emailController  = TextEditingController(
      text: widget.initialEmail
    );

    _enableSaveButtonNotif = ValueNotifier<bool>(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getPeachColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 40.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTextButton(buttonName: "Cancel", onTap: (){
                        Navigator.pop(context);
                      }),
                      buildTextButton(buttonName: "Logout", onTap: () async{
                        await AuthService().signOut().then((value){
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.authScreen,
                                  (route) => route.isFirst
                          );
                        });
                      }),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0
                  )
              ),
              Align(
                child: buildScreenTitle(
                    content: "Edit profile", topPadding: 0.0, bottomPadding: 0.0
                ),
                alignment: Alignment.centerLeft,
              ),
              getUserImage(
                  key: const Key("userImage"),
                  imageUrl: widget.userImageUrl,
                  marginVertPad: 20.0
              ),
              CustomTextFieldValidator(
                textFieldKey: const Key("fullNameFieldKey"),
                label: "Full name",
                constantValidation: true,
                textEditingController: _fullNameController,
                marginVertPad: 8.0,
                validator: (val) => _fullNameController.text.length > 3
                    ? null
                    : "Name is too short",
                onChanged: (val){
                  if(_fullNameController.text.length < 3){
                    _enableSaveButtonNotif.value = false;
                  }else{
                    _enableSaveButtonNotif.value = true;
                  }
                },
              ),
              BuildTextField(
                key: const Key("emailFieldKey"),
                label: "Email",
                enabled: false,
                controller: _emailController,
                marginVertPad: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0
                ) ,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState){
                    return buildTextButton(
                      buttonName: "Delete account",
                      textColor: getRedColor,
                      onTap:  (authState is UserState)
                          ? () async{
                        await AuthService().deleteAccount(
                            authState.user
                        );
                      }
                          : null,
                      borderRadius: 10.0,
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (blocContext, authState){
                    return ValueListenableBuilder<bool>(
                        valueListenable: _enableSaveButtonNotif,
                        builder: (context, enableButton, child){
                          return BuildButton(
                              disableColor: getVioletColor.withOpacity(0.3),
                              marginVertPad: 20.0,
                              buttonName: "Save",
                              onPressed: (authState is UserState && enableButton)
                                  ? () async{
                                showLoadingDialog(
                                    content: "Saving...",
                                    context: context,
                                    dialogFunc: (dialogContext) async{

                                      FocusManager.instance.primaryFocus!.unfocus();

                                      await UserService().updateUserInfo(
                                          name: _fullNameController.text,
                                          uid: authState.user.uid
                                      ).then((value){
                                        Navigator.pop(dialogContext);
                                        Navigator.pop(context);
                                      });
                                    }
                                );
                              }
                                  : null
                          );
                        }
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

