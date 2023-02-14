import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        backgroundColor: getPeachColor,
        appBar: getLeadingOnlyAppBar(context: context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Center(
                  child: BlocBuilder<UserInfoBloc, UserInfoState>(
                      builder: (context, userInfoState){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getUserImage(
                                key: const Key("profile_user_image_key"),
                                imageUrl: (userInfoState is FetchedUserInfoState)
                                    ? userInfoState.userModel.photoUrl
                                    : null
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                (userInfoState is FetchedUserInfoState)
                                    ? userInfoState.userModel.name
                                    : " ",
                                style: StuartTextStyles.w60030,
                              ),
                            ),
                            if(userInfoState is FetchedUserInfoState) Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: buildTextButton(
                                  buttonName: "Edit", onTap: (){
                                Navigator.pushNamed(
                                    context, RouteNames.editProfileScreen,
                                    arguments: {
                                      "initialName": userInfoState.userModel.name,
                                      "initialEmail": userInfoState.userModel.email,
                                      "userImageUrl": userInfoState.userModel
                                          .photoUrl
                                    }
                                );
                              }
                              ),
                            )
                          ],
                        );
                      }
                  ),
                ),
              ),
              buildOptionTile(title: "Payment method", onPressed: (){
                Navigator.pushNamed(
                    context, RouteNames.paymentMethodScreen
                );
              }, leadingIconUrl: "assets/payment_logo.png"),
              buildOptionTile(title: "charging history", onPressed: (){
                Navigator.pushNamed(
                    context, RouteNames.chargingHistoryScreen
                );
              }, leadingIconUrl: "assets/charging_logo.png"),
              buildOptionTile(title: "RFID card", onPressed: (){
                Navigator.pushNamed(
                    context, RouteNames.rfidCardScreen
                );
              }, leadingIconUrl: "assets/rfid_logo.png"),
              Padding(
                padding:  const EdgeInsets.only(top: 25.0, bottom: 8.0),
                child: Text(
                  "Information",
                  style: StuartTextStyles.w60018,
                ),
              ),
              buildOptionTile(title: "Report an issue", onPressed: (){
                Navigator.pushNamed(context, RouteNames.reportScreen);
              }),
              buildOptionTile(title: "Terms & Conditions", onPressed: (){
                Navigator.pushNamed(
                    context,
                    RouteNames.webViewScreen,
                    arguments: {
                      "url" : "https://www.stuart.energy/docs/privacy-policy-app"
                    }
                );
              }),
              buildOptionTile(title: "Privacy policy", onPressed: (){
                Navigator.pushNamed(
                    context,
                    RouteNames.webViewScreen,
                    arguments: {
                      "url" : "https://www.stuart.energy/docs/privacy-policy-app"
                    }
                );
              }),
              buildOptionTile(title: "About", onPressed: (){
                Navigator.pushNamed(
                    context,
                    RouteNames.webViewScreen,
                    arguments: {
                      "url" : "https://www.stuart.energy/about"
                    }
                );
              }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "STUART ENERGY™ v1.1.2(208)",
                    style: StuartTextStyles.w60012,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
