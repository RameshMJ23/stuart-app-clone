
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/add_card_screen.dart';
import 'package:stuartappclone/screens/profile_screens/charging_history.dart';
import '../../lib/screens/auth_screen/auth_screen.dart';
import '../constants.dart';

void main(){

  Widget mockChargingHistoryScreen() => mockMaterialWrap(ChargingHistoryScreen());

  testWidgets("testing charging history screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockChargingHistoryScreen());

    //text // all passed
    expect(find.text("All transaction"), findsOneWidget);


  });
}