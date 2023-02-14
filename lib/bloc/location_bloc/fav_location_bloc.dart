

import 'package:bloc/bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/data/model/location_model.dart';
import 'package:stuartappclone/data/services/location_service.dart';
import 'package:stuartappclone/data/services/user_service.dart';

class FavLocationBloc extends Cubit<LocationState>{

  FavLocationBloc():super(LoadingLocationState()){
    UserInfoBloc().stream.listen((event) async{
      if(event is FetchedUserInfoState){
        LocationService().getFavChargingPoints(event.userModel.favourites)
                                .listen((favChargingPoints) async{
          if(event != null){
            await LocationBloc.loadLocationIcon().then((icons){
              emit(FetchedLocationState(
                  locations: favChargingPoints, iconList: icons));
            });
          }
        });
      }
    });
  }

}