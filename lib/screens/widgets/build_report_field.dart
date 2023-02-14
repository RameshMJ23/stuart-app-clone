
import 'package:flutter/material.dart';

import '../constants/StuartTextStyles.dart';

class BuildReportField extends StatelessWidget {

  final layerLink = LayerLink();

  String fieldName;
  String hintText;
  bool multiLine;
  bool enableCheckBox;
  bool showCheckBox;

  BuildReportField({
    required this.fieldName,
    required this.hintText,
    this.multiLine = false,
    this.enableCheckBox = false,
    this.showCheckBox = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              fieldName,
              style: StuartTextStyles.w60016,
            ),
          ),
          TextField(
            maxLines: multiLine ? null: 1,
            minLines: multiLine ? 6 : 1,
            decoration: InputDecoration(
              hintText: hintText,
              border: _reportFieldBorder,
              focusedErrorBorder: _reportFieldBorder,
              focusedBorder: _reportFieldBorder,
              enabledBorder: _reportFieldBorder,
              fillColor: Colors.white.withOpacity(0.75),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10.0
              ),
              hintStyle: StuartTextStyles.w40014
            ),
            style: StuartTextStyles.w40016.copyWith(color: Colors.black87),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder get _reportFieldBorder => OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: const BorderSide(color: Colors.transparent)
);
