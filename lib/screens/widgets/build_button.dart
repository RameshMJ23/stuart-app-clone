
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import '../constants/constants.dart';

class BuildButton extends StatelessWidget {

  Key? key;

  String? buttonName;

  Color contentColor;

  Color buttonColor;

  VoidCallback? onPressed;

  double vertPad;

  double horzPad;

  double marginVertPad;

  String? customButtonText;

  IconData? customButtonIcon;

  Color? iconColor;

  Color? splashColor;

  double? iconSize;

  bool showBorder;

  Color? disableColor;

  Color? disabledTextColor;

  Color? borderColor;

  BuildButton({
    required this.buttonName,
    required this.onPressed,
    this.contentColor = Colors.white,
    this.buttonColor = const Color(0xFF8D6E97),
    this.vertPad = 12.0,
    this.marginVertPad = 0.0,
    this.horzPad = 0.0,
    this.splashColor,
    this.key,
    this.showBorder = false,
    this.disableColor,
    this.disabledTextColor,
    this.borderColor
  }):super(key: key);

  BuildButton.transparent({
    required this.buttonName,
    required this.onPressed,
    this.contentColor = const Color(0xFF8D6E97),
    this.buttonColor = Colors.transparent,
    this.vertPad = 12.0,
    this.marginVertPad = 0.0,
    this.horzPad = 0.0,
    this.splashColor,
    this.key,
    this.showBorder = false,
    this.disableColor,
    this.disabledTextColor,
    this.borderColor
  }):super(key: key);

  BuildButton.custom({
    required this.onPressed,
    this.contentColor = Colors.black87,
    this.buttonColor = Colors.transparent,
    this.vertPad = 12.0,
    this.marginVertPad = 0.0,
    required this.customButtonIcon,
    this.iconColor = Colors.black87,
    required this.customButtonText,
    this.horzPad = 12.0,
    this.splashColor,
    this.iconSize = 25.0,
    this.key,
    this.showBorder = false,
    this.disableColor,
    this.disabledTextColor,
    this.borderColor
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertPad),
      child: MaterialButton(
          enableFeedback: onPressed == null ? false : true,
          disabledColor: disableColor,
          disabledTextColor: disabledTextColor,
          padding: EdgeInsets.symmetric(vertical: vertPad, horizontal: horzPad),
          elevation: 0.0,
          highlightElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: showBorder
                ? (borderColor ?? getVioletColor)
                : Colors.transparent
            )
          ),
          color: buttonColor,
          splashColor: splashColor ?? contentColor.withOpacity(0.4),
          child: (customButtonText != null && customButtonIcon != null)
          ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                customButtonText!,
                style: StuartTextStyles.w50014.copyWith(
                  color: contentColor
                ),
              ),
              Icon(
                customButtonIcon,
                color: iconColor,
                size: iconSize,
              )
            ],
          )
          : Text(
            buttonName!,
            style: StuartTextStyles.w50014.copyWith(
              color: contentColor
            ),
          ),
          onPressed: onPressed,
        ),
    );
  }
}
