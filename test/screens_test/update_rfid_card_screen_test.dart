import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/profile_screens/rfid_card.dart';
import 'package:stuartappclone/screens/profile_screens/update_rfid_screen.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import '../constants.dart';

void main(){

  Widget mockUpdateRFIDCardScreen() => mockMaterialWrap(UpdateRFIDScreen());

  testWidgets("testing update RFID card screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockUpdateRFIDCardScreen());

    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Update RFID number"), findsOneWidget);

    final rfidCardNumberField = find.byKey(const Key("rfid_card_number_field"));

    expect(find.byKey(const Key("scan_rfid_card_button")), findsOneWidget);
    expect(rfidCardNumberField, findsOneWidget);

    final saveButton = find.byKey(const Key("update_rfid_save_button"));
    final input = tester.firstWidget<BuildButton>(saveButton);
    expect(input.onPressed, isNull);

    // not passing even after pump (i.e) onPressed is still null
    // after entering text into textfield

    await tester.enterText(find.byType(TextField), "1234");
    await tester.pump();
    expect(find.text("1234"), findsOneWidget);
    expect(input.onPressed, isNotNull);

  });
}