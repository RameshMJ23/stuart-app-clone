

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';
import 'package:stuartappclone/bloc/location_bloc/location_state.dart';
import 'package:stuartappclone/data/model/bitmap_descriptor_model.dart';
import 'package:stuartappclone/data/model/location_model.dart';
import 'package:stuartappclone/data/services/location_service.dart';

class LocationBloc extends Cubit<LocationState>{

  LocationBloc():super(LoadingLocationState());

  defaultLocation(){
    LocationService().getChargingPoints().listen((event) {
      if(event != null){
        loadLocationIcon().then((locationIcons){
          emit(FetchedLocationState(
            locations: event,
            iconList: locationIcons
          ));
        });
      }
    });
  }

  filterLocation(FilterState filterState) async{
    LocationService().getChargingPoints().listen((event) async{

      List<LocationModel>? locations;

      loadLocationIcon().then((locationIcons) async{

        final allLocation = await LocationService().getChargingPoints().first;

        final rangeFilteredLocation = allLocation.where(
          (location) => _checkPower(
            location: location,
            highestPower: double.parse(filterState.highestPowerRange),
            lowestPower: double.parse(filterState.lowestPowerRange)
          )
        ).toList();

        if(filterState.type1){

          if(locations == null){

            locations = rangeFilteredLocation.where(
                (element) => _checkType1(element)).toList();

          }else{

            final _locationToAdd =
              rangeFilteredLocation.where(
                      (element) => _checkType1(element)).toList();

            locations!.addAll(_locationToAdd);
          }
        }

        if(filterState.type2){

          if(locations == null){
            locations = rangeFilteredLocation.where(
                    (element) => _checkType2(element)).toList();
          }else{
            final _locationToAdd =
              rangeFilteredLocation.where(
                      (element) => _checkType2(element)).toList();

            locations!.addAll(_locationToAdd);
          }
        }

        if(filterState.availConnectors){

          if(locations == null){
            locations = rangeFilteredLocation.where(
                    (element) => _checkAvail(element)).toList();
          }else{
            locations = locations!.where(
                    (element) => _checkAvail(element)).toList();
          }
        }

        if(filterState.publicConnectors){

          if(locations == null){

            locations = rangeFilteredLocation.where(
              (element) => element.public
            ).toList();

          }else{
            locations = locations!.where(
                    (element) => element.public).toList();
          }
        }

        emit(FetchedLocationState(
          locations: locations!,
          iconList: locationIcons
        ));

      });
    });
  }

  _checkPower({
    required LocationModel location,
    required double highestPower,
    required double lowestPower
  }){
    return location.connection_info.where(
      (e) => (e.power >= lowestPower && e.power <= highestPower)
    ).toList().isNotEmpty;
  }
  
  _checkAvail(LocationModel location){
    return location.connection_info.where(
      (e) => e.available
    ).toList().isNotEmpty;
  }

  _checkType1(LocationModel location){
    return location.connection_info.where(
      (e) => e.Connector_type == "Type 1"
    ).toList().isNotEmpty;
  }

  _checkType2(LocationModel location){
    return location.connection_info.where(
      (e) => e.Connector_type == "Type 2"
    ).toList().isNotEmpty;
  }

  static Future<List<BitMapDescriptorModel>> loadLocationIcon() async{

    BitmapDescriptor _greenWithoutKey =  await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/green_without_key.png"
    );

    BitmapDescriptor _greenWithKey =  await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/green_with_key.png"
    );

    BitmapDescriptor _redWithoutKey =  await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/red_without_key.png"
    );

    BitmapDescriptor _redWithKey =  await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/red_with_key.png"
    );

    return [
      BitMapDescriptorModel(
        bitMapEnum: BitMapDescriptorEnum.greenWithKey, image: _greenWithKey
      ),
      BitMapDescriptorModel(
        bitMapEnum: BitMapDescriptorEnum.greenWithoutKey, image: _greenWithoutKey
      ),
      BitMapDescriptorModel(
        bitMapEnum: BitMapDescriptorEnum.redWithKey, image: _redWithKey
      ),
      BitMapDescriptorModel(
        bitMapEnum: BitMapDescriptorEnum.redWithoutKey, image: _redWithoutKey
      )
    ];
  }
}