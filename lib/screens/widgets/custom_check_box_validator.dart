
import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';

class CustomCheckBoxValidator extends FormField<bool>{

  CustomCheckBoxValidator({
    required VoidCallback onPressed,
    required FormFieldValidator<bool> validator,
    FormFieldSetter<bool>? onSaved,
    GlobalKey<FormFieldState>? key,
    required bool isChecked,
    String? hyperLinkContent,
    String? hyperLink,
  }):super(
      onSaved: onSaved,
      validator: validator,
      key: key,
      builder: (FormFieldState<bool> state){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChecker(
                isChecked: isChecked,
                hyperLink: hyperLink,
                hyperLinkContent: hyperLinkContent
              ),
              state.errorText != null ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3.0, horizontal: 15.0
                ),
                child: Text(
                  state.errorText!,
                  style: StuartTextStyles.w50013,
                ),
              ): const SizedBox(height: 0.0,width: 0.0)
            ],
          ),
          onTap: onPressed,
        );
      }
  );
}

Widget _buildChecker({
  String content = "I agree to our",
  String? hyperLinkContent,
  double vertPad = 0.0,
  String? hyperLink,
  double fontSize = 14.0,
  required bool isChecked
}) => Row(
  children: [
    Checkbox(
      value: isChecked,
      activeColor: getVioletColor,
      onChanged: (val){

      }
    ),
    Expanded(
      child: RichText(
        text: TextSpan(
          text: content + " ",
          style: StuartTextStyles.w40014.copyWith(
            color: Colors.black87,
            fontSize: fontSize
          ),
          children: [
            if(hyperLink != null) TextSpan(
              text: hyperLinkContent,
              style: StuartTextStyles.w40014.copyWith(color: getVioletColor)
            )
          ]
        ),
      ),
    )
  ],
);