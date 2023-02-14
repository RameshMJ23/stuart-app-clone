

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stuartappclone/main.dart';
import '../../lib/screens/auth_screen/auth_screen.dart';

import '../constants.dart';

void main(){

  Widget mockAuthScreen() => mockMaterialWrap(AuthScreen());

  testWidgets("testing AuthScreen", (WidgetTester tester) async{


    await tester.pumpWidget(mockAuthScreen());

    //text // all passed
    expect(find.text("Stuart Ev"), findsOneWidget);
    expect(find.text("Charge your car effortlessly"), findsOneWidget);
    expect(find.text("Or"), findsOneWidget);

    expect(find.byType(MaterialButton), findsWidgets);

    await tester.tap(find.text("Log in with Google"));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

  });
}