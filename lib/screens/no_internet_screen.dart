import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_state.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';

class NoInternetScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      showNoInternetDialog(context);
    });

    return BlocListener<InternetBloc, InternetState>(
      listener: (blocContext, internetState){
        if(internetState is YesInternetState){
          
          if(ModalRoute.of(context)?.isCurrent != true){
            Navigator.pop(context);
          }

          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: getVioletColor,
          ),
        )
      ),
    );
  }

  showNoInternetDialog(BuildContext context){
    showErrorDialog(
      title: "No internet \nconnection",
      content: "Please check your internet connection and try again",
      context: context,
      onPressed: (){
        Future.delayed(const Duration(seconds: 2), (){
          showNoInternetDialog(context);
        });
      }
    );
  }
}
