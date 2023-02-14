

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';
import 'package:stuartappclone/data/model/location_model.dart';

class LocationService{

  final CollectionReference _chargerRef =
                      FirebaseFirestore.instance.collection("chargers");


  List<LocationModel> _fireDataToStream(QuerySnapshot snapshot){
    return snapshot.docs.map(
      (e) => LocationModel.firebaseToLocation(e)
    ).toList();
  }

  Stream<List<LocationModel>> getChargingPoints(){
    return _chargerRef.snapshots().map(_fireDataToStream);
  }

  Stream<List<LocationModel>> getFavChargingPoints(List favPoints){
    return _chargerRef.snapshots().map(_fireDataToStream).map(
          (location) => _getFavLocation(location, favPoints));
  }

  List<LocationModel> _getFavLocation(
    List<LocationModel> locationList,List favPoints
  ){
    List<LocationModel> favLocations = [];

    locationList.map((location){
      if(favPoints.contains(location.chargerId)){
        favLocations.add(location);
      }
    }).toList();

    return favLocations;
  }

}