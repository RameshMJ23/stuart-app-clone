import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/filter_screen.dart';
import 'package:stuartappclone/screens/profile_screens/edit_profile_screen.dart';
import 'package:stuartappclone/screens/profile_screens/payment_method_screen.dart';
import '../../lib/screens/auth_screen/sign_up_screen.dart';
import '../constants.dart';

void main(){

  Widget mockFilterScreen() => mockMaterialWrap(FilterScreen(
    initAvailConnectorsVal: false,
    initPublicParkingVal: false,
    initType1Val: true,
    initType2Val: true,
    initLowestPowerRange: "0.0",
    initHighestPowerRange: "175.0",
  ));

  testWidgets("testing Filter screen", (WidgetTester tester) async{

    await tester.pumpWidget(mockFilterScreen());

    final type1Switch = find.byKey(const Key("Type_1_switch_key"));
    final type2Switch = find.byKey(const Key("Type_2_switch_key"));
    final availSwitch = find.byKey(const Key("avail_connectors_switch_key"));
    final publicParkingSwitch = find.byKey(
        const Key("public_parking_switch_key")
    );
    // final rangeSlider = find.byType(RangeSlider);

    expect(find.text("Filter"), findsOneWidget);
    expect(find.text("Done"), findsOneWidget);

    expect(type1Switch, findsOneWidget);
    expect(type2Switch, findsOneWidget);
    expect(availSwitch, findsOneWidget);
    expect(publicParkingSwitch, findsOneWidget);

    await tester.tap(type1Switch);
    await tester.pump();

    await tester.tap(type2Switch);
    await tester.pump();

    await tester.tap(availSwitch);
    await tester.pump();

    await tester.tap(publicParkingSwitch);
    await tester.pump();

    // Dragging range slider doesn't work

    //await tester.drag(rangeSlider, Offset(150, 0));
    await tester.pump();

    expect(tester.firstWidget<Switch>(type1Switch).value, true);
    expect(tester.firstWidget<Switch>(type2Switch).value, true);
    expect(tester.firstWidget<Switch>(availSwitch).value, true);
    expect(tester.firstWidget<Switch>(publicParkingSwitch).value, true);
    //expect(tester.firstWidget<RangeSlider>(rangeSlider).min, 29.0);

    await tester.pumpAndSettle();

  });
}