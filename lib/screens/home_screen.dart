

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/fav_location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_state.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/build_icon_button.dart';
import 'package:stuartappclone/screens/widgets/scroll_charger_sheet_wiget.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
                           with AutomaticKeepAliveClientMixin{

  late final GoogleMapController mapController;

  late final ValueNotifier<bool> permissionNotifier;

  @override
  void initState() {
    // TODO: implement initState
    permissionNotifier = ValueNotifier(false);

    _getPermission();


    if(!isFilterEnabled(BlocProvider.of<FilterBloc>(context).state)){
      BlocProvider.of<LocationBloc>(context).defaultLocation();
    }

    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: permissionNotifier,
                builder: (context, bool val, child){
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.505,
                    child: Stack(
                      children: [
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, locationState){
                            return GoogleMap(
                              key: const Key("Map"),
                              myLocationButtonEnabled: false,
                              myLocationEnabled: val,
                              compassEnabled: true,
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: false,
                              rotateGesturesEnabled: true,
                              tiltGesturesEnabled: false,
                              mapToolbarEnabled: true,
                              initialCameraPosition: const CameraPosition(
                                  target: LatLng(55.1694, 23.8813),
                                  zoom: 7.0
                              ),
                              onMapCreated: (controller){
                                mapController = controller;
                              },
                              markers: (locationState is FetchedLocationState)
                                  ? locationState.locations.map((location){
                                return Marker(
                                    markerId: MarkerId(location.location.latitude.toString()),
                                    icon: getEvIcon(location, locationState.iconList),
                                    position: LatLng(
                                        location.location.latitude,
                                        location.location.longitude
                                    )
                                );
                              }).toList().toSet(): {},
                            );
                          },
                        ),
                        Positioned(
                          right: 10.0,
                          bottom: 15.0,
                          child: BuildIconButton(
                            icon: Icons.gps_fixed,
                            onPressed: (){

                            },
                            buttonColor: Colors.white,
                            iconColor: Colors.black87,
                          ),
                        ),
                        BlocBuilder<UserInfoBloc, UserInfoState>(
                          builder: (context, userInfoState){

                            final userImage = (
                              userInfoState is FetchedUserInfoState
                                && userInfoState.userModel.photoUrl != null
                            )
                            ? BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  userInfoState.userModel.photoUrl!
                                )
                              ),
                              shape: BoxShape.circle
                            )
                            : const BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage(
                                  "assets/person_icon.jpg"
                                )
                              ),
                              shape: BoxShape.circle
                            );

                            return Positioned(
                                right: 15.0,
                                top: 25.0,
                                child: GestureDetector(
                                  child: Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: userImage
                                  ),
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RouteNames.profileScreen
                                    );
                                  },
                                )
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
              MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: BlocProvider.of<LocationBloc>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<FilterBloc>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<FavLocationBloc>(context),
                    )
                  ],
                  child: ScrollChargerSheetWidget()
              )
            ],
          ),
        ),
      ),
    );
  }

  _getPermission() async{
    Permission.locationWhenInUse.request().then((permission){
      if(permission == PermissionStatus.granted){
        permissionNotifier.value = true;
      }else{
        permissionNotifier.value = false;
      }
    });
  }



}
