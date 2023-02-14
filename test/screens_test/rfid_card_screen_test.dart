import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/rfid_card.dart';
import '../../lib/screens/auth_screen/sign_up_screen.dart';

import '../constants.dart';


void main(){

  Widget mockRFIDCardScreen() => mockMaterialWrap(RFIDCardScreen());

  testWidgets("testing RFID card screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockRFIDCardScreen());

    expect(find.text("RFID card"), findsOneWidget);

    expect(find.byKey(const Key("rfid_logo")), findsOneWidget);
    expect(find.byKey(const Key("rfid_number")), findsOneWidget);
    expect(find.byKey(const Key("rfid_exp_text")), findsOneWidget);
    expect(find.byKey(const Key("update_rfid_button")), findsOneWidget);

  });
}