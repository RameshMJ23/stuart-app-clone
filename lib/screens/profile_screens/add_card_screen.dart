import 'package:easy_card_scanner/credit_card_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:stuartappclone/screens/widgets/build_textfield.dart';
import 'package:stuartappclone/screens/widgets/custom_check_tile.dart';
import 'package:stuartappclone/screens/widgets/custom_text_field_validator.dart';

class AddCardScreen extends StatelessWidget {

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyCodeController = TextEditingController();
  final TextEditingController _companyAddressController = TextEditingController();
  final TextEditingController _vatCodeController = TextEditingController();

  final ValueNotifier<bool> _companyDetailsNotif = ValueNotifier<bool>(false);
  final ValueNotifier<int> _expDateInputLengthNotif = ValueNotifier<int>(0);
  final ValueNotifier<int> _cardNumInputLengthNotif = ValueNotifier<int>(0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: getPeachColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextButton(buttonName: "Cancel", onTap: (){
                  Navigator.pop(context);
                }),
                buildScreenTitle(content: "Add card"),
                BuildButton.custom(
                  key: const Key("scan_credit_button"),
                  customButtonText: "Scan Credit Card",
                  customButtonIcon: Icons.center_focus_strong,
                  contentColor: getVioletColor,
                  iconColor: getVioletColor,
                  onPressed: () async{
                    await CardScanner.scanCard().then((cardDetails){
                      if(cardDetails != null){
                        _cardNumberController.text = cardDetails.cardNumber;
                        _expDateController.text = cardDetails.expiryDate;
                      }
                    });
                  },
                  showBorder: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<int>(
                            valueListenable: _cardNumInputLengthNotif,
                            builder: (context, prevInputLength, child){
                              return CustomTextFieldValidator(
                                maxLengthOfChar: 19,
                                marginVertPad: 5.0,
                                textEditingController: _cardNumberController,
                                label: "Card Number",
                                keyboardType: TextInputType.number,
                                textFieldKey: const Key("card_num_field"),
                                onChanged: (val){

                                  final len = val!.length;

                                  if((len == 4 || len == 9 || len == 14)
                                      && len > prevInputLength){
                                    _cardNumberController.value = TextEditingValue(
                                        text: _cardNumberController.text + " ",
                                        selection: TextSelection.collapsed(
                                            offset: _cardNumberController.text.length +1
                                        )
                                    );
                                  }

                                  _cardNumInputLengthNotif.value = len;

                                },
                                validator: (val){
                                  return (
                                      _cardNumberController.text.length < 19
                                          || !(_cardNumberController.text.startsWith("2")
                                          || _cardNumberController.text.startsWith("4")
                                          || _cardNumberController.text.startsWith("5"))
                                  )
                                      ? "Invalid card number": null;
                                },
                              );
                            }
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _expDateInputLengthNotif,
                          builder: (context, prevInputLength, child){
                            return CustomTextFieldValidator(
                              maxLengthOfChar: 5,
                              marginVertPad: 5.0,
                              textEditingController: _expDateController,
                              label: "MM/YY",
                              keyboardType: TextInputType.number,
                              textFieldKey: const Key("exp_date_field"),
                              onChanged: (val){
                                if(val!.length == 2
                                    && !val.contains("/")
                                    && prevInputLength < val.length
                                ){
                                  ///Working
                                  _expDateController.value = TextEditingValue(
                                      text: _expDateController.text + "/",
                                      selection: TextSelection.collapsed(
                                          offset: _expDateController.text.length +1
                                      )
                                  );
                                }

                                _expDateInputLengthNotif.value = val.length;

                                if(val.contains("/") &&  val.length <= 2){
                                  _expDateController.value = TextEditingValue(
                                      text: "0" + _expDateController.text,
                                      selection: TextSelection.collapsed(
                                          offset: _expDateController.text.length +1
                                      )
                                  );
                                }
                              },
                              validator: (val){
                                return _validateExpirationDate(
                                    _expDateController.text
                                );
                              },
                            );
                          },
                        ),
                        CustomTextFieldValidator(
                          maxLengthOfChar: 4,
                          marginVertPad: 5.0,
                          textEditingController: _ccvController,
                          label: "CCV",
                          keyboardType: TextInputType.number,
                          textFieldKey: const Key("ccv_field"),
                          validator: (val){
                            return (_ccvController.text.length < 3)
                                ? "Invalid CCV": null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
                CustomCheckTile(
                  checkBoxKey: const Key("addCompanyCheckBox"),
                  content: "Add company details for invoicing?",
                  fontSize: 15.0,
                  onChecked: (val){
                    _companyDetailsNotif.value = val!;
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: _companyDetailsNotif,
                    builder: (context, bool val, child){
                      return val
                          ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              BuildTextField(
                                marginVertPad: 5.0,
                                label: "Company name",
                                keyboardType: TextInputType.text,
                                controller: _companyNameController,
                                key: const Key("companyNameField"),
                              ),
                              BuildTextField(
                                  marginVertPad: 5.0,
                                  label: "Company code",
                                  keyboardType: TextInputType.text,
                                  controller: _companyCodeController,
                                  key: const Key("companyCodeField")
                              ),
                              BuildTextField(
                                  marginVertPad: 5.0,
                                  label: "Company address",
                                  keyboardType: TextInputType.text,
                                  controller: _companyAddressController,
                                  key: const Key("companyAddressField")
                              ),
                              BuildTextField(
                                  marginVertPad: 5.0,
                                  label: "VAT code(optional)",
                                  keyboardType: TextInputType.text,
                                  controller: _vatCodeController,
                                  key: const Key("vatField")
                              )
                            ]
                        ),
                      )
                          : const SizedBox(height: 100,);
                    }
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (builderContext, userInfoState){
                      return (userInfoState is FetchedUserInfoState)
                          ? BuildButton(
                          key: const Key("save_button"),
                          buttonName: "Save",
                          onPressed: () async {

                            FocusManager.instance.primaryFocus!.unfocus();

                            if(_formKey.currentState!.validate()){
                              showLoadingDialog(
                                  content: "Adding card...",
                                  context: context,
                                  dialogFunc: (dialogContext){
                                    BlocProvider.of<UserInfoBloc>(context).addCard(
                                      uid: (BlocProvider.of<AuthBloc>(
                                          context
                                      ).state as UserState
                                      ).user.uid,
                                      cardList: userInfoState.userModel.cards,
                                      cardNumber: _cardNumberController.text,
                                      expMonth: _separateExpDate(
                                        _expDateController.text, getMonth: true
                                      ),
                                      expYear: _separateExpDate(
                                        _expDateController.text, getYear: true
                                      ),
                                      ccv: _ccvController.text,
                                      companyName: _companyNameController.text,
                                      companyCode: _companyCodeController.text,
                                      companyAddress: _companyAddressController.text,
                                      companyVat: _vatCodeController.text
                                    ).then((value) {
                                      Navigator.pop(dialogContext);
                                      _cardNumberController.clear();
                                      _expDateController.clear();
                                      _ccvController.clear();
                                      Navigator.pop(context);
                                    });
                                  }
                              );
                            }
                          }
                      )
                      : const SizedBox.shrink();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateExpirationDate(String input){

    if(input.length < 3){
      return "Invalid expiration date";
    }

    List<String> splitText = input.split("/");

    int yearNow = int.parse(DateTime.now().year.toString().substring(2));

    int month = int.parse(splitText.first);

    if(month.isNegative || month > 12
        || yearNow > int.parse(splitText[1]) || splitText.isEmpty){
      return "Invalid expiration date";
    }else{
      return null;
    }
  }

  String _separateExpDate(String input, {bool? getMonth, bool? getYear}){

    List<String> splitText = input.split("/");

    return (getMonth != null && getMonth)
       ? splitText[0]
       : (getYear != null && getYear)
       ? splitText[1]
       : "";
  }
}
