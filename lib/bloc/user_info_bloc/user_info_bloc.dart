

import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/data/model/card_detail_model.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:collection/collection.dart';

class UserInfoBloc extends Cubit<UserInfoState>{

  UserInfoBloc():super(LoadingUserInfoState()){
    AuthBloc().stream.listen((event) {
      if(event is UserState){
        UserService().fetchUserData(event.user.uid).listen((event) {
          emit(FetchedUserInfoState(event.first));
        });
      }
    });
  }

  Future<void> favouriteEvPoint({
    required List favouriteList,
    required String chargerId,
    required bool alreadyFav,
    required String uid
  }) async{

    alreadyFav ? favouriteList.remove(chargerId) : favouriteList.add(chargerId);

    return await UserService().favouriteItem(uid, favouriteList);

  }

  Future<void> addCard({
    required String uid,
    required List<CardDetailModel> cardList,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String ccv,
    String? companyName,
    String? companyCode,
    String? companyAddress,
    String? companyVat,
  }) async{


    final cardDetails = CardDetailModel(
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      ccv: ccv,
      companyName: (companyName != null && companyName.isNotEmpty)
          ? companyName : null,
      companyCode: (companyCode != null && companyCode.isNotEmpty)
          ? companyName : null,
      companyAddress: (companyAddress != null && companyAddress.isNotEmpty)
          ? companyName : null,
      vatCode: (companyVat != null && companyVat.isNotEmpty)
          ? companyName : null,
      defaultCard: cardList.isEmpty
    );

    cardList.add(cardDetails);

    await UserService().addRemoveCard(uid, cardDetailModelToMapList(cardList));

  }

  Future<void> removeCard({
    required String uid,
    required List<CardDetailModel> cardList,
    required int index
  }) async{

    cardList.removeAt(index);

    await UserService().addRemoveCard(uid, cardDetailModelToMapList(cardList));

  }

  Future<void> makeCardDefault({
    required String uid,
    required List<CardDetailModel> cardList,
    required int index
  }) async{

    final newcardList = cardList.mapIndexed(
      (i, e) => i == index
        ? e.copyWith(defaultCard: true)
        : e.copyWith(defaultCard: false)
    ).toList();

    await UserService().addRemoveCard(
        uid, cardDetailModelToMapList(newcardList));

  }
}