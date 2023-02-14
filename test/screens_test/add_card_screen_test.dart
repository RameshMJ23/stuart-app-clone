

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/add_card_screen.dart';
import '../../lib/screens/auth_screen/auth_screen.dart';
import '../constants.dart';

void main(){

  Widget mockAddCardScreen() => mockMaterialWrap(AddCardScreen());

  testWidgets("testing Add card screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockAddCardScreen());

    //text // all passed
    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Add card"), findsOneWidget);


    final saveButton = find.byKey(const Key("save_button"));

    expect(find.byKey(const Key("scan_credit_button")), findsOneWidget);
    expect(saveButton, findsOneWidget);

    expect(find.byKey(const Key("card_num_field")), findsOneWidget);
    expect(find.byKey(const Key("exp_date_field")), findsOneWidget);
    expect(find.byKey(const Key("ccv_field")), findsOneWidget);


    expect(find.byKey(const Key("companyNameField")), findsNothing);
    expect(find.byKey(const Key("companyCodeField")), findsNothing);
    expect(find.byKey(const Key("companyAddressField")), findsNothing);
    expect(find.byKey(const Key("vatField")), findsNothing);

    final checkBox = find.byKey(const Key("addCompanyCheckBox"));

    await tester.tap(checkBox);

    await tester.pump();

    await tester.scrollUntilVisible(
      saveButton,
      50.0,
      scrollable: find.byType(Scrollable).last
    );

    await tester.pump();

    expect(find.byKey(const Key("companyNameField")), findsOneWidget);
    expect(find.byKey(const Key("companyCodeField")), findsOneWidget);
    expect(find.byKey(const Key("companyAddressField")), findsOneWidget);
    expect(find.byKey(const Key("vatField")), findsOneWidget);

  });
}