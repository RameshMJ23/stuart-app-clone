
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stuartappclone/data/model/user_model.dart';

abstract class UserInfoState extends Equatable{}

class LoadingUserInfoState extends UserInfoState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedUserInfoState extends UserInfoState{

  UserModel userModel;

  FetchedUserInfoState(this.userModel);

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}