
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserState extends AuthState{

  User user;

  UserState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];

}

class NoUserState extends AuthState{}

class LoadingAuthState extends AuthState{}