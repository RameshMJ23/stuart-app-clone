

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stuartappclone/screens/profile_screens/edit_profile_screen.dart';
import '../../lib/screens/auth_screen/sign_up_screen.dart';

import '../constants.dart';


void main(){

  Widget mockEditProfileScreen() => mockMaterialWrap(EditProfileScreen(
    initialEmail: "abc@gmail.com",
    initialName: "Ramesh ma",
    userImageUrl: null,
  ));

  testWidgets("testing Edit profile screen", (WidgetTester tester) async{

    // Passes when main vertical padding (40) is (20)

    await tester.pumpWidget(mockEditProfileScreen());

    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Logout"), findsOneWidget);
    expect(find.text("Edit profile"), findsOneWidget);

    expect(find.byKey(const Key("userImage")), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(2));

    expect(find.text("Delete account"), findsOneWidget);

    expect(find.text("Save"), findsOneWidget);

    await tester.pump();
  });
}