import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_bloc.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';
import 'package:stuartappclone/bloc/location_bloc/fav_location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_state.dart';
import 'package:stuartappclone/data/model/connection_info.dart';
import 'package:stuartappclone/data/model/location_model.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/build_icon_button.dart';

import '../constants/StuartTextStyles.dart';
import '../constants/constants.dart';

class ScrollChargerSheetWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      minChildSize: 0.49,
      initialChildSize: 0.49,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 15.0
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: getPeachColor
          ),
          child: Column(
            children: [
              BlocBuilder<FavLocationBloc, LocationState>(
                builder: (context, favPointsState){
                  return (favPointsState is FetchedLocationState
                    && favPointsState.locations.isNotEmpty
                  )
                   ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildScreenTitle(
                        content: "Favourites",
                        topPadding: 0.0,
                        bottomPadding: 0.0
                      ),
                      CarouselSlider(
                        items: favPointsState.locations.map(
                          (points) => _buildChargerTile(
                            evTitle: points.title,
                            evAddress: points.address,
                            distance: points.distance,
                            isAvail: points.limitedAccess,
                            connectionInfo: points.connection_info,
                            context: context,
                            position: LatLng(
                              points.location.latitude,
                              points.location.longitude
                            ),
                            icon: getEvIcon(points, favPointsState.iconList),
                            chargerId: points.chargerId,
                            powerPadding: 5.0,
                            powerFontSize: 14.0,
                            powerIconSize: 12.0,
                            powerMarginLeftPad: 5.0,
                            tileHorizonPad: 8.0
                          )
                        ).toList(),
                        options: CarouselOptions(
                          height: 125,
                          aspectRatio: 16/9,
                          viewportFraction: 0.9,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          padEnds: false
                        )
                      )
                    ],
                  )
                  : const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildScreenTitle(
                      content: "Nearby",
                      topPadding: 0.0,
                      bottomPadding: 0.0
                    ),
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, filterState){
                        return BuildIconButton.transparent(
                          showFilterActivated: isFilterEnabled(filterState),
                          icon: CupertinoIcons.slider_horizontal_3,
                          onPressed: (){
                            Navigator.pushNamed(
                              context,
                              RouteNames.filterScreen,
                              arguments: {
                                "initType1Val": filterState.type1,
                                "initType2Val": filterState.type2,
                                "initPublicParkingVal": filterState.publicConnectors,
                                "initAvailConnectorsVal": filterState.availConnectors,
                                "initLowestPowerRange": filterState.lowestPowerRange,
                                "initHighestPowerRange": filterState.highestPowerRange,
                              }
                            );
                          },
                          borderColor: getVioletColor,
                          splashColor: getVioletColor.withOpacity(0.4),
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, locationState){
                    return (locationState is FetchedLocationState)
                    ? locationState.locations.isEmpty
                    ? Center(
                      child: Text(
                        "No locations found",
                        style: StuartTextStyles.w60018,
                      ),
                    )
                    : ListView.builder(
                      controller: scrollController,
                      itemCount: locationState.locations.length,
                      itemBuilder: (BuildContext listContext, int index) {

                        final location = locationState.locations[index];

                        return _buildChargerTile(
                          evTitle: location.title,
                          evAddress: location.address,
                          distance: location.distance,
                          isAvail: false,
                          limitedAccess: location.limitedAccess,
                          connectionInfo: location.connection_info,
                          context: context,
                          position: LatLng(
                            location.location.latitude,
                            location.location.longitude
                          ),
                          icon: getEvIcon(location, locationState.iconList),
                          chargerId: location.chargerId
                        );

                      },
                    )
                    : Center(
                      child: CircularProgressIndicator(
                        color: getVioletColor,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildChargerTile({
    required String evTitle,
    required String evAddress,
    required String distance,
    bool limitedAccess = true,
    required bool isAvail,
    required List<ConnectionInfo> connectionInfo,
    required BuildContext context,
    required LatLng position,
    required BitmapDescriptor icon,
    required String chargerId,
    double powerPadding = 8.0,
    double powerFontSize = 16.0,
    double powerIconSize = 16.0,
    double powerMarginLeftPad = 5.0,
    double tileHorizonPad = 0.0
  }) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    child:  Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0, horizontal: tileHorizonPad
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0, horizontal: 10.0
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(limitedAccess) buildKeyIcon(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      evTitle,
                      style: StuartTextStyles.w50022,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                //const Spacer(),
                Text(
                  distance + " km",
                  style: StuartTextStyles.w50022,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              evAddress,
              style: StuartTextStyles.w50014.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Row(
            children: connectionInfo.map((e){
              return Container(
                margin: EdgeInsets.only(
                  top: 3.0, bottom: 3.0, left: powerMarginLeftPad
                ),
                padding: EdgeInsets.symmetric(
                  vertical: powerPadding, horizontal: 8.0
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: e.available
                    ? getGreenColor
                    : getRedColor
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: powerIconSize,
                      width: powerIconSize,
                      child: Image.asset(
                        "assets/type 2 charger logo white.png"
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0
                      ),
                      child: Text(
                        e.power.toString() + " kW",
                        style: StuartTextStyles.w50016.copyWith(
                          color: Colors.white,
                          fontSize: powerFontSize
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    ),
    onTap: (){
      Navigator.pushNamed(
        context, RouteNames.chargerPointScreen,
        arguments: {
          "title": evTitle,
          "distance": distance,
          "address": evAddress,
          "isPublic": limitedAccess,
          "chargersList": connectionInfo,
          "position": position,
          "icon": icon,
          "chargerId": chargerId
        }
      );
    },
  );

}



