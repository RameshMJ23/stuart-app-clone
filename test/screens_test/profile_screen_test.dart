import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/profile_screen.dart';
import '../constants.dart';


void main(){

  Widget mockProfileScreen() => mockMaterialWrap(ProfileScreen());

  testWidgets("testing Profile Screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockProfileScreen());

    expect(find.byKey(const Key("profile_user_image_key")), findsOneWidget);

    expect(find.text("Edit"), findsOneWidget);

    expect(find.text("Payment method"), findsOneWidget);
    expect(find.text("charging history"), findsOneWidget);
    expect(find.text("RFID card"), findsOneWidget);

    final endText = find.text("STUART ENERGY™ v1.1.2(208)");

    expect(endText, findsNothing);

    await tester.scrollUntilVisible(
        endText,
        50.0,
        scrollable: find.byType(Scrollable).last
    );

    await tester.pump();

    expect(find.text("Report an issue"), findsOneWidget);
    expect(find.text("Terms & Conditions"), findsOneWidget);
    expect(find.text("Privacy policy"), findsOneWidget);
    expect(find.text("About"), findsOneWidget);
    
  });
}