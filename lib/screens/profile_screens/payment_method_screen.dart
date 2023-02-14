import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';

class PaymentMethodScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPeachColor,
      appBar: getLeadingOnlyAppBar(
        context: context,
        trailingWidgets: [
          Align(
            child: buildTextButton(buttonName: "Add card", onTap: (){
              Navigator.pushNamed(context, RouteNames.addCardScreen);
            }),
            alignment: Alignment.centerRight,
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildScreenTitle(content: "Payment method"),
            Text(
              "Your card",
              style: StuartTextStyles.w60018,
            ),
            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, userInfoState){
                return (userInfoState is FetchedUserInfoState
                    && userInfoState.userModel.cards.isNotEmpty)
                ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index){

                        final cardDetails = userInfoState.userModel.cards[index];

                        String cardNumToShow = getCardNumToShow(cardDetails);

                        return MaterialButton(
                          highlightElevation: 0.0,
                          elevation: 0.0,
                          splashColor: getVioletColor.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  cardDetails.cardNumber.startsWith("4")
                                    ? buildVisaCard()
                                    : buildMasterCard(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 3.0
                                    ),
                                    child: Text(
                                      cardNumToShow,
                                      style: StuartTextStyles.w40016,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  if(cardDetails.defaultCard) Text(
                                    "Default",
                                    style: StuartTextStyles.w50016,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.0,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          onPressed: (){
                            Navigator.pushNamed(
                              context,
                              RouteNames.cardDetailScreen,
                              arguments: {
                                "cardList": userInfoState.userModel.cards,
                                "index": index
                              }
                            );
                          },
                        );
                      },
                      itemCount: userInfoState.userModel.cards.length,
                      separatorBuilder: (context, index){
                        return const Divider(color: Colors.white,);
                      },
                    ),
                  ),
                )
                : noHistoryAvail(
                  key: const Key("no_card_avail_key"),
                  icon: Icons.credit_card,
                  content: "No cards added!"
                );
              },
            )
          ],
        ),
      )
    );
  }
}
