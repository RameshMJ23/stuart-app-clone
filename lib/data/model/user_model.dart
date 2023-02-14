

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuartappclone/data/model/card_detail_model.dart';

class UserModel{

  String email;

  String name;

  String uid;

  String? photoUrl;

  List favourites;

  List<CardDetailModel> cards;

  String rfid;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.photoUrl,
    required this.favourites,
    required this.cards,
    required this.rfid
  });

  static Map<String, dynamic> modelToFireData(UserModel userModel){
    return {
      "email" : userModel.email,
      "name" : userModel.name,
      "uid" : userModel.uid,
      "photoUrl" : userModel.photoUrl,
      "favourites": userModel.favourites,
      "cards": cardDetailModelToMapList(userModel.cards),
      "rfid": userModel.rfid
    };
  }

  factory UserModel.modelFromFireData(QueryDocumentSnapshot doc){

    final data = doc.data() as Map;

    return UserModel(
      email: data['email'],
      name: data['name'],
      uid: data['uid'],
      photoUrl: data['photoUrl'],
      favourites: data['favourites'],
      cards: mapToCardDetailModelList(data['cards']),
      rfid: data['rfid']
    );

  }

}