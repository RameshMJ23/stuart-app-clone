

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/screens/auth_screen/sign_up_screen.dart';

import '../constants.dart';


void main(){

  Widget mockSignUpScreen() => mockMaterialWrap(SignUpScreen());

  testWidgets("testing Signup screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockSignUpScreen());

    expect(find.byType(TextField), findsNWidgets(5));

    expect(find.byType(MaterialButton), findsWidgets);

    final loginButton = find.text("Sign in with Google");

    await tester.scrollUntilVisible(
      find.text("Sign in with Google"),
      50.0,
      scrollable: find.byType(Scrollable).last
    );

    await tester.pump(Duration(seconds: 1));
    await tester.tap(loginButton);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}