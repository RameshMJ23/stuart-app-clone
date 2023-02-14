
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/edit_profile_screen.dart';
import 'package:stuartappclone/screens/profile_screens/payment_method_screen.dart';
import '../../lib/screens/auth_screen/sign_up_screen.dart';
import '../constants.dart';


void main(){

  Widget mockPaymentMethodScreen() => mockMaterialWrap(PaymentMethodScreen());

  testWidgets("testing Payment method screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockPaymentMethodScreen());

    expect(find.text("Add card"), findsOneWidget);
    expect(find.text("Payment method"), findsOneWidget);
    expect(find.text("Your card"), findsOneWidget);

    expect(find.byKey(const Key("no_card_avail_key")), findsOneWidget);

    await tester.pump();
  });
}