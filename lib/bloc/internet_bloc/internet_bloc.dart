import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_state.dart';

class InternetBloc extends Cubit<InternetState>{

  InternetBloc():super(RefreshingInternetState()){
    Connectivity().onConnectivityChanged.listen((event) async{
      if(event != ConnectivityResult.none){
        await InternetConnectionChecker().hasConnection.then((value){
          if(value){
            emit(YesInternetState());
          }else{
            emit(NoInternetState());
          }
        });
      }else{
        emit(NoInternetState());
      }
    });
  }


}