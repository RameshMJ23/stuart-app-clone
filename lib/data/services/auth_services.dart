import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stuartappclone/data/services/user_service.dart';

class AuthService{

  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStream => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassWord({
    required String email,
    required String password
  }) async{
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassWord({
    required String email,
    required String password,
    required String name,
  }) async{
    try{
      return _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      ).then((value) async{
        if(value != null){
          await UserService().createNewUserInfo(
            email: email,
            name: name,
            uid: value.user!.uid
          );
        }
      });
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async{
    try{
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
          scopes: <String>["email"]
      ).signIn();

      GoogleSignInAuthentication googleAuthentication =
                                await googleSignInAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken
      );

      if(await _checkEmail(googleSignInAccount.email)){
        UserCredential userCredential = await _auth.signInWithCredential(credentials);

        return userCredential;
      }

      return null;
    }catch(e){
      return null;
    }
  }

  Future<UserCredential?> signUpWithGoogle() async{
    try{
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(scopes: <String>["email"]).signIn();

      GoogleSignInAuthentication googleAuthentication = await googleSignInAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken
      );

      return _auth.signInWithCredential(credentials).then((userCredential) async{
        return await UserService().createNewUserInfo(
          email: googleSignInAccount.email,
          name: googleSignInAccount.displayName ?? "",
          uid: userCredential.user!.uid,
          photoUrl: googleSignInAccount.photoUrl
        );
      });

    }catch(e){
      return null;
    }
  }

  Future<bool> _checkEmail(String email) async{

    late bool isThere;

    await _auth.fetchSignInMethodsForEmail(email).then((listOfMethods){
      if(listOfMethods.isEmpty){
        isThere = false;
      }else{
        isThere = true;
      }
    });

    return isThere;
  }

  Future signOut() async{
    return await _auth.signOut().then((value) async{
      await GoogleSignIn().signOut();
    });
  }

  Future deleteAccount(User user) async{
    return await UserService().deleteUserInfo(user.uid).then((value) async{
      await user.delete();
    });
  }
}