
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (blocContext, authState){
        if(authState is NoUserState){
          Navigator.pushReplacementNamed(context, RouteNames.authScreen);
        }else if(authState is UserState){
          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        }
      },
      child: Scaffold(
        backgroundColor: getPeachColor,
        body: Center(
          child: CircularProgressIndicator(
            color: getVioletColor,
          ),
        ),
      ),
    );
  }
}
