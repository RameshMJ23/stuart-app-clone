import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/constants.dart';

class BuildIconButton extends StatelessWidget {

  Key? key;

  double buttonDimension;

  IconData icon;

  VoidCallback onPressed;

  Color? buttonColor;

  Color? borderColor;

  Color? iconColor;

  Color? splashColor;

  bool? showFilterActivated;

  BuildIconButton({
    required this.icon,
    required this.onPressed,
    required this.buttonColor,
    this.key,
    this.buttonDimension = 40.0,
    required this.iconColor,
    this.borderColor = Colors.transparent,
    this.splashColor = Colors.black26
  }):super(key: key);

  BuildIconButton.transparent({
    required this.icon,
    required this.onPressed,
    this.key,
    this.buttonColor = Colors.transparent,
    required this.borderColor,
    this.buttonDimension = 40.0,
    this.iconColor,
    this.splashColor,
    this.showFilterActivated
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonDimension,
      width: buttonDimension,
      child: MaterialButton(
        splashColor: splashColor,
        padding: EdgeInsets.zero,
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonDimension),
          side: BorderSide(
            color: borderColor!
          )
        ),
        color: buttonColor,
        child: Center(
          child: Stack(
            children: [
              Icon(
                icon,
                color: iconColor ?? borderColor,
                size: 18.0
              ),
              if(showFilterActivated != null && showFilterActivated!) Positioned(
                right: 0.0,
                child: CircleAvatar(
                  radius: 5.0,
                  backgroundColor: getVioletColor,
                ),
              )
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
