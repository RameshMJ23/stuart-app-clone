import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';

import '../constants/constants.dart';
import '../widgets/build_button.dart';
import '../widgets/build_textfield.dart';

class UpdateRFIDScreen extends StatelessWidget {

  final TextEditingController _rfidNumberController = TextEditingController();

  final ValueNotifier<bool> buttonEnabler = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getPeachColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextButton(buttonName: "Cancel", onTap: (){
                Navigator.pop(context);
              }),
              buildScreenTitle(content: "Update RFID number", fontSize: 29),
              BuildButton.custom(
                key: const Key("scan_rfid_card_button"),
                customButtonText: "Scan RFID Card",
                customButtonIcon: Icons.center_focus_strong,
                contentColor: getVioletColor,
                iconColor: getVioletColor,
                onPressed: () async{

                  FocusManager.instance.primaryFocus!.unfocus();

                  await NfcManager.instance.isAvailable().then((isAvail){
                    if(isAvail){
                      NfcManager.instance.startSession(
                          onDiscovered: (nfcTag) async{
                            if(Ndef.from(nfcTag) != null){
                              _rfidNumberController.text
                              = Ndef.from(nfcTag).toString();
                            }
                          }
                      );
                    }else{
                      showErrorDialog(
                          title: "Error",
                          content: "NFC may not be supported or may be "
                              "temporarily turned off",
                          context: context
                      );
                    }
                  });
                },
                showBorder: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: BuildTextField(
                  key: const Key("rfid_card_number_field"),
                  marginVertPad: 5.0,
                  controller: _rfidNumberController,
                  label: "RFID card number",
                  keyboardType: TextInputType.name,
                  onChanged: (val){
                    if(val!.isNotEmpty){
                      buttonEnabler.value = true;
                    }else{
                      buttonEnabler.value = false;
                    }
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: buttonEnabler,
                  builder: (builderContext, bool val, child){
                    return BuildButton(
                        key: const Key("update_rfid_save_button"),
                        disabledTextColor: Colors.white54,
                        disableColor: getVioletColor.withOpacity(0.5),
                        buttonName: "Save",
                        onPressed: val
                            ? () async{

                          FocusManager.instance.primaryFocus!.unfocus();

                          showLoadingDialog(
                              context: context,
                              dialogFunc: (dialogContext) async{
                                await UserService().updateRfidNumber(
                                    (BlocProvider.of<AuthBloc>(
                                        context).state as UserState).user.uid,
                                    _rfidNumberController.text
                                ).then((value){
                                  Navigator.pop(dialogContext);
                                  Navigator.pop(context);
                                });
                              },
                              content: "Updating..."
                          );
                        }
                        : null
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
