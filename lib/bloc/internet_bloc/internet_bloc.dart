import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_state.dart';

class InternetBloc extends Cubit<InternetState>{

  InternetBloc():super(RefreshingInternetState()){
    Connectivity().onConnectivityChanged.listen((event) async{

      log("Check internet calledd intermediate state 1 emitted with ${event.toString()}================");

      if(event != ConnectivityResult.none){
        await InternetConnectionChecker().hasConnection.then((value){
          log("Check internet calledd intermediate state 2 emitted with ${value.toString()}================");
          if(value){

            log("Check internet calledd Yes intenet state emitted================");
            emit(YesInternetState());
          }else{
            log("Check internet calledd No internet state emitted 1111 ================");
            emit(NoInternetState());
          }
        });
      }else{
        log("Check internet calledd No internet state emitted 2222 ================");
        emit(NoInternetState());
      }
    });
  }

  /*checkInternet(){

    log("Check internet calledd ================");



    log("Check internet calledd Refreshing state emitted================");

    Connectivity().onConnectivityChanged.listen((event) async{
      emit(RefreshingInternetState());

      log("Check internet calledd intermediate state 1 emitted with ${event.toString()}================");

      if(event != ConnectivityResult.none){
        await InternetConnectionChecker().hasConnection.then((value){
          log("Check internet calledd intermediate state 2 emitted with ${value.toString()}================");
          if(value){

            log("Check internet calledd Yes intenet state emitted================");
            emit(YesInternetState());
          }else{
            log("Check internet calledd No internet state emitted 1111 ================");
            emit(NoInternetState());
          }
        });
      }else{
        log("Check internet calledd No internet state emitted 2222 ================");
        emit(NoInternetState());
      }
    });
  }
*/
  /*checkInternet(){
    emit(RefreshingInternetState());
    Connectivity().onConnectivityChanged.listen((event) async{
      if(event != ConnectivityResult.none){
        await InternetConnectionChecker().hasConnection.then((value){
          value ? emit(YesInternetState()) : Timer.periodic(
            const Duration(seconds: 3,), (val){
              log("No Internet State is emitted 11111======================");
              emit(NoInternetState());
            }
          );
        });
      }else{
        Timer.periodic(
          const Duration(seconds: 3,), (val){
          log("No Internet State is emitted 222222222======================");
           emit(NoInternetState());
          }
        );
      }
    });
  }*/

}