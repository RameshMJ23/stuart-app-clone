import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/StuartTextStyles.dart';
import '../constants/constants.dart';

enum showSuffixEnum{
  enabledButObscureText,
  enabledVisibleText,
  disabledButObscureText,
  disabledVisibleText,
}

class BuildTextField extends StatelessWidget {

  Key? key;
  String? label;
  String? errorText;
  bool? showSuffixWidget;
  TextEditingController? controller;
  double marginVertPad;
  bool enabled;
  TextInputType? keyboardType;
  Function(String?)? onChanged;
  int? maxLengthOfChar;

  BuildTextField({
    this.label,
    String? errorText,
    this.showSuffixWidget = false,
    this.controller,
    this.marginVertPad = 0.0,
    this.key,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLengthOfChar
  }):super(key: key);

  BuildTextField.password({
    required this.label,
    String? errorText,
    this.showSuffixWidget = true,
    this.controller,
    this.marginVertPad = 0.0,
    this.key,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLengthOfChar
  }):super(key: key);

  ValueNotifier<showSuffixEnum> iconStateNotif =
                      ValueNotifier<showSuffixEnum>(showSuffixEnum.disabledButObscureText);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: enabled
          ? Colors.white70
          : Colors.grey.shade200
      ),
      margin: EdgeInsets.symmetric(vertical: marginVertPad, horizontal: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      height: 55.0,
      child: Row(
        children: [
          Expanded(
            child: Focus(
              child: ValueListenableBuilder(
                valueListenable: iconStateNotif,
                builder: (context,showSuffixEnum val, child){

                  bool obscureText = (showSuffixWidget != null && showSuffixWidget!)
                      && (val == showSuffixEnum.disabledButObscureText
                          || val == showSuffixEnum.enabledButObscureText);

                  return TextField(
                    enabled: enabled,
                    controller: controller,
                    inputFormatters: [
                      if(maxLengthOfChar != null)
                        LengthLimitingTextInputFormatter(maxLengthOfChar)
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder:  InputBorder.none,
                      enabledBorder:  InputBorder.none,
                      labelText: label,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0
                      ),
                      labelStyle: StuartTextStyles.normal16.copyWith(
                        color: Colors.grey.shade600
                      ),
                    ),
                    style: TextStyle(
                      color: enabled
                        ? Colors.black87
                        : Colors.grey.shade600
                    ),
                    obscureText: obscureText,
                    cursorColor: getVioletColor,
                    keyboardType: keyboardType,
                    onChanged: onChanged,
                  );
                },
              ),
              onFocusChange: (isFocused){
                if(isFocused){

                  if(iconStateNotif.value == showSuffixEnum.disabledVisibleText){
                    iconStateNotif.value = showSuffixEnum.enabledVisibleText;
                  }else if(iconStateNotif.value == showSuffixEnum.disabledButObscureText){
                    iconStateNotif.value = showSuffixEnum.enabledButObscureText;
                  }

                }else{

                  if(iconStateNotif.value == showSuffixEnum.enabledVisibleText){
                    iconStateNotif.value = showSuffixEnum.disabledVisibleText;
                  }else if(iconStateNotif.value == showSuffixEnum.enabledButObscureText){
                    iconStateNotif.value = showSuffixEnum.disabledButObscureText;
                  }

                }
              },
            ),
          ),
          if(showSuffixWidget != null && showSuffixWidget!) ValueListenableBuilder(
            valueListenable: iconStateNotif,
            builder: (context, showSuffixEnum iconState, child){
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  child: Icon(
                    (iconState == showSuffixEnum.enabledButObscureText
                    || iconState == showSuffixEnum.disabledButObscureText)
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye_fill,
                    color: (iconState == showSuffixEnum.disabledVisibleText
                        || iconState == showSuffixEnum.disabledButObscureText)
                      ? Colors.grey.shade600
                      : getVioletColor,
                  ),
                  onTap: (iconState == showSuffixEnum.disabledButObscureText ||
                  iconState == showSuffixEnum.disabledVisibleText)
                    ? null
                    : (){
                      if(iconState == showSuffixEnum.enabledVisibleText){
                        iconStateNotif.value = showSuffixEnum.enabledButObscureText;
                      }else{
                        iconStateNotif.value = showSuffixEnum.enabledVisibleText;
                      }
                    },
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
