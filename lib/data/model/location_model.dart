
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuartappclone/data/model/connection_info.dart';

class LocationModel{

  String address;

  String title;

  List<ConnectionInfo> connection_info;

  String distance;

  bool limitedAccess;

  GeoPoint location;

  String power;

  bool public;

  String chargerId;

  LocationModel({
    required this.title,
    required this.address,
    required this.limitedAccess,
    required this.connection_info,
    required this.distance,
    required this.location,
    required this.public,
    required this.chargerId,
    this.power = "22.0",
  });

  factory LocationModel.firebaseToLocation(QueryDocumentSnapshot doc){
    final data = doc.data() as Map;

    return LocationModel(
      title: data["title"],
      address: data["address"],
      limitedAccess: data["limitedAccess"],
      connection_info: mapToConnectionInfoList(data["connection_info"]),
      distance: data["distance"],
      location: data["location"],
      public: data['public'],
      chargerId: data["charger_id"]
    );

  }
}