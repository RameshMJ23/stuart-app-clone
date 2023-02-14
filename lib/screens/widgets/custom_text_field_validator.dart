import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/widgets/build_textfield.dart';

enum ValidatorTextFieldEnum{
  normal,
  password
}

class CustomTextFieldValidator extends FormField<String>{

  CustomTextFieldValidator({
    required TextEditingController textEditingController,
    Function(String?)? onChanged,
    required FormFieldValidator<String> validator,
    FormFieldSetter<String>? onSaved,
    GlobalKey<FormFieldState>? key,
    Key? textFieldKey,
    required String label,
    bool? showSuffixWidget,
    required double marginVertPad,
    ValidatorTextFieldEnum textFieldEnum = ValidatorTextFieldEnum.normal,
    bool constantValidation = false,
    int? maxLengthOfChar,
    TextInputType? keyboardType
  }):super(
      onSaved: onSaved,
      validator: validator,
      key: key,
      builder: (FormFieldState<String> state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldEnum == ValidatorTextFieldEnum.normal
            ? BuildTextField(
              key: textFieldKey,
              label: label,
              showSuffixWidget: showSuffixWidget,
              controller: textEditingController,
              onChanged: (val){
                if(onChanged != null) onChanged(val);
                if(constantValidation){
                  state.validate();
                }
              },
              keyboardType: keyboardType,
              marginVertPad: marginVertPad,
              maxLengthOfChar: maxLengthOfChar,
            )
            : BuildTextField.password(
              controller: textEditingController,
              label: label,
              marginVertPad: marginVertPad,
              onChanged: (val){
                if(onChanged != null){
                  onChanged(val);
                }

                if(constantValidation){
                  state.validate();
                }
              },
              maxLengthOfChar: maxLengthOfChar,
            ),
            state.errorText != null ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3.0, horizontal: 3.0
              ),
              child: Text(
                state.errorText!,
                style: StuartTextStyles.w50013,
              ),
            ): const SizedBox(height: 0.0,width: 0.0)
          ],
        );
      }
  );
}
