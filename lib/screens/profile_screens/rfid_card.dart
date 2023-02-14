import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';

class RFIDCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        appBar: getLeadingOnlyAppBar(context: context),
        backgroundColor: getPeachColor,
        body: Padding(
          padding: const EdgeInsets.only(
              right: 20.0, left: 20.0, top: 0.0, bottom: 40.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildScreenTitle(content: "RFID card"),
              Row(
                children: [
                  Container(
                    key: const Key("rfid_logo"),
                    height: 20.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/rfid_image.jpg",
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: BlocBuilder<UserInfoBloc, UserInfoState>(
                      builder: (context, userState){
                        return Text(
                          (userState is FetchedUserInfoState)
                              ? userState.userModel.rfid
                              : " ",
                          style: StuartTextStyles.normal16,
                          key: const Key("rfid_number"),
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "This the RFID card number assigned to you. You can change it to a different one "
                      "and use that card to charge",
                  style: StuartTextStyles.w50015,
                  key: const Key("rfid_exp_text"),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: BuildButton(
                    key: const Key("update_rfid_button"),
                    buttonName: "Update RFID number",
                    onPressed: (){
                      Navigator.pushNamed(context, RouteNames.updateRfidScreen);
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
