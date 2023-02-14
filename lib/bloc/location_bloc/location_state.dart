
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stuartappclone/data/model/bitmap_descriptor_model.dart';
import 'package:stuartappclone/data/model/location_model.dart';

abstract class LocationState extends Equatable{}

class LoadingLocationState extends LocationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedLocationState extends LocationState{

  List<LocationModel> locations;

  List<BitMapDescriptorModel> iconList;

  FetchedLocationState({
    required this.locations, required this.iconList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [locations, iconList];

}
