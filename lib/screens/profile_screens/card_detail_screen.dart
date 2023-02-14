
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/data/model/card_detail_model.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:collection/collection.dart';

class CardDetailScreen extends StatelessWidget {

  List<CardDetailModel> cardList;

  int index;

  CardDetailScreen({
    required this.cardList,
    required this.index
  });

  @override
  Widget build(BuildContext context) {

    final cardDetails = cardList[index];

    return NoInternetScreenBuilder(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cardDetails.cardNumber.startsWith("4")
                        ? buildVisaCard(height: 50, width: 65)
                        : buildMasterCard(height: 50, width: 65),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0
                      ),
                      child: Column(
                        children: [
                          Text(
                              cardDetails.cardNumber.startsWith("4")
                                  ? "Visa" : "Mastercard",
                              style: StuartTextStyles.w60016.copyWith(
                                  color: Colors.black87)
                          ),
                          Text(
                              "xxxx xxxx xxxx ${cardDetails.cardNumber.substring(15, 19)}",
                              style: StuartTextStyles.w60016.copyWith(
                                  color: Colors.black87)
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0
                      ),
                      child: Text(
                          "${cardDetails.expMonth}/20${cardDetails.expYear}",
                          style: StuartTextStyles.w60016.copyWith(color: Colors.grey)
                      ),
                    ),
                    (cardDetails.defaultCard)
                        ? Text(
                      "This is your default card",
                      style: StuartTextStyles.w60016,
                    )
                        : SizedBox(
                      width: double.infinity,
                      child: BuildButton.transparent(
                        buttonName: "Make default",
                        onPressed: (){
                          showLoadingDialog(
                              context: context,
                              dialogFunc: (dialogContext){
                                BlocProvider.of<UserInfoBloc>(context).makeCardDefault(
                                    uid: (BlocProvider.of<AuthBloc>(
                                        context
                                    ).state as UserState).user.uid,
                                    cardList: cardList,
                                    index: index
                                ).then((value){
                                  Navigator.pop(dialogContext);
                                  Navigator.pop(context);
                                });
                              },
                              content: "Making card default..."
                          );
                        },
                        showBorder: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: BuildButton.transparent(
                          buttonName: "Remove card",
                          onPressed: () async{
                            showLoadingDialog(
                                context: context,
                                dialogFunc: (dialogContext){
                                  BlocProvider.of<UserInfoBloc>(context).removeCard(
                                      uid: (BlocProvider.of<AuthBloc>(
                                          context
                                      ).state as UserState).user.uid,
                                      cardList: cardList,
                                      index: index
                                  ).then((value){
                                    Navigator.pop(dialogContext);
                                    Navigator.pop(context);
                                  });
                                },
                                content: "Removing card..."
                            );
                          },
                          contentColor: getRedColor,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: BuildButton(
                              buttonName: "Done",
                              onPressed: (){
                                Navigator.pop(context);
                              }
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
