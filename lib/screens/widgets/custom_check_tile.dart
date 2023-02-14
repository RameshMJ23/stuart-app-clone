
import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import '../constants/constants.dart';

class CustomCheckTile extends StatelessWidget {

  Key? checkBoxKey;

  ValueNotifier<bool> checkBoxNotif = ValueNotifier<bool>(false);

  String content;

  String? hyperLinkContent;

  double vertPad;

  String? hyperLink;

  double fontSize;

  Function(bool?)? onChecked;

  CustomCheckTile({
    this.content = "I agree to our",
    this.hyperLinkContent,
    this.vertPad = 0.0,
    this.hyperLink,
    this.fontSize = 14.0,
    this.onChecked,
    this.checkBoxKey
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertPad),
      child: GestureDetector(
        child: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: checkBoxNotif,
                builder: (context, bool value, child){
                  return Checkbox(
                    key: checkBoxKey,
                    value: value,
                    activeColor: getVioletColor,
                    onChanged: (val){
                      /*if(onChecked != null) onChecked!(val);
                      checkBoxNotif.value = val!;*/
                    }
                  );
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
        ),
        onTap: (){
          checkBoxNotif.value = !checkBoxNotif.value;
          if(onChecked != null) onChecked!(checkBoxNotif.value);
        },
      )
    );
  }
}
