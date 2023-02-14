import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';

class CustomSwitchTile extends StatefulWidget {

  bool? initialVal;

  String title;

  String? imageUrl;

  Function(bool)? onChangeFunc;

  Key? switchKey;

  CustomSwitchTile({
    this.initialVal,
    required this.title,
    this.imageUrl,
    this.onChangeFunc,
    this.switchKey
  });

  @override
  _CustomSwitchTileState createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {

  late final ValueNotifier<bool> _switchNotifier;

  @override
  void initState() {
    // TODO: implement initState
    _switchNotifier = ValueNotifier<bool>(widget.initialVal ?? false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _switchNotifier,
      builder: (context, bool isEnabled, child){
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 5.0, vertical: 0.0
              ),
              title: Text(
                widget.title,
                style: StuartTextStyles.w50016,
              ),
              horizontalTitleGap: 0.0,
              trailing: Switch(
                key: widget.switchKey,
                activeColor: getVioletColor,
                value: isEnabled,
                onChanged: (val){
                  if(widget.onChangeFunc != null) widget.onChangeFunc!(val);
                  _switchNotifier.value = val;
                },
              ),
              leading: widget.imageUrl != null
              ? SizedBox(
                height: 25.0,
                width: 25.0,
                child: Image.asset(
                  widget.imageUrl!
                ),
              )
              : null,
            ),
            const Divider(
              color: Colors.white70, thickness: 1.2, height: 0.5,
            )
          ],
        );
      }
    );
  }
}

