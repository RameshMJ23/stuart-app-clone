import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuartappclone/data/model/user_model.dart';

class UserService{

  final CollectionReference _userCollectionRef =
            FirebaseFirestore.instance.collection("user_info");

  createNewUserInfo({
    required String email,
    required String name,
    required String uid,
    String? photoUrl
  }){
    _userCollectionRef.doc(uid).set(UserModel.modelToFireData(UserModel(
      email: email,
      name: name,
      photoUrl: photoUrl,
      uid: uid,
      favourites: [],
      cards: [],
      rfid: uid.toUpperCase().substring(0,14)
    )));
  }

  Future<void> updateUserInfo({
    required String name,
    required String uid
  }) async{
    return await _userCollectionRef.doc(uid).update({
      "name": name,
    });
  }

  List<UserModel> _userFromStream(QuerySnapshot snapshot){
    return snapshot.docs.map((e) => UserModel.modelFromFireData(e)).toList();
  }

  Stream<List<UserModel>> fetchUserData(String userId){
    return _userCollectionRef.where(
      "uid",
      isEqualTo: userId
    ).snapshots().map(_userFromStream);
  }
  
  Future<void> deleteUserInfo(String userId) async{
    return await _userCollectionRef.doc(userId).delete();
  }

  Future favouriteItem(String uid, List favList) async{
    return await _userCollectionRef.doc(uid).update({
      "favourites": favList
    });
  }

  Future updateRfidNumber(String uid, String rfid) async{
    return await _userCollectionRef.doc(uid).update({
      "rfid": rfid
    });
  }

  Future addRemoveCard(String uid, List cardList) async{
    return await _userCollectionRef.doc(uid).update({
      "cards": cardList
    });
  }

}