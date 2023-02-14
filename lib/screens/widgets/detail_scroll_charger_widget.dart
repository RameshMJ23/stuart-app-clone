import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stuartappclone/data/model/connection_info.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/ev_info_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/StuartTextStyles.dart';
import '../constants/constants.dart';

class DetailScrollChargerWidget extends StatelessWidget {

  String title;

  String distance;

  String address;

  bool isPublic;

  List<ConnectionInfo> chargersList;

  double latitude;

  double longitude;

  Function(bool, bool) onPanelExpanded;

  DetailScrollChargerWidget({
    required this.title,
    required this.distance,
    required this.address,
    required this.isPublic,
    required this.chargersList,
    required this.latitude,
    required this.longitude,
    required this.onPanelExpanded
  });

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
              color: Colors.white
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: buildScreenTitle(
                        content: title,
                        topPadding: 0.0,
                        bottomPadding: 0.0,
                        fontSize: 24
                      ),
                    ),
                    buildScreenTitle(
                      content: distance + " Km",
                      topPadding: 0.0,
                      bottomPadding: 0.0,
                      fontSize: 24
                    )
                  ],
                ),
              ),
              Text(
                address,
                style: StuartTextStyles.w50016.copyWith(
                  color: Colors.grey.shade600
                ),
              ),
              if(isPublic) _limitedAccessWidget(),
              Column(
                children: chargersList.map(
                  (chargerInfo) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: BuildEvInfoWidget(
                      connectionInfo: chargerInfo,
                      onExpanded: (isOpen){
                        onPanelExpanded(isOpen, chargerInfo.available);
                      },
                    ),
                  )
                ).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    _buildSheetOptionsTile(
                      title: "Navigate using Map",
                      iconUrl: "assets/navigate_using_map.png",
                      onPressed: (){
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)
                            )
                          ),
                          context: context,
                          builder: (context){
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 15.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: Image.asset(
                                          "assets/google_maps_logo.png"
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0
                                      ),
                                      child: Text(
                                        "Google Maps",
                                        style: StuartTextStyles.w50014,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){
                                MapsLauncher.launchCoordinates(
                                  latitude, longitude
                                );
                              },
                            );
                          }
                        );
                      }
                    ),
                    _buildSheetOptionsTile(
                      title: "how to charge",
                      iconUrl: "assets/how_to_charge.png",
                      onPressed: (){
                        Navigator.pushNamed(
                          context, RouteNames.webViewScreen, arguments: {
                          "url": "https://www.stuart.energy/docs/how-to-charge"
                        });
                      }
                    ),
                    _buildSheetOptionsTile(
                      title: "Share location",
                      iconUrl: "assets/share_location_logo.png",
                      onPressed: () async{
                        await Share.share("To navigate to $title station use"
                          " https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
                      }
                    ),
                    _buildSheetOptionsTile(
                      title: "Report an issue",
                      iconUrl: "assets/report_issue_logo.png",
                      onPressed: (){
                        Navigator.pushNamed(context, RouteNames.reportScreen);
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


  /*void navigateTo(double lat, double lng) async {

    Uri uri = Uri(scheme: 'geo', host: '0,0',
        queryParameters: {'q': '$lat,$lng'}
    );


    if (await canLaunch(uri.toString())) {
      await launch(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }

  }*/

  Widget _buildSheetOptionsTile({
    required String title,
    required String iconUrl,
    required VoidCallback onPressed
  }) => Container(
    margin: const EdgeInsets.symmetric(
      vertical: 4.0
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: getPeachColor,
    ),
    child: buildOptionTile(
      vertPad: 3.0,
      title: title,
      onPressed: onPressed,
      leadingIconUrl: iconUrl,
      leadingIconSize: 20.0
    ),
  );

  Widget _limitedAccessWidget() => Container(
    decoration: BoxDecoration(
      color: getPeachColor,
      borderRadius: BorderRadius.circular(8.0)
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 15.0, horizontal: 12.0
    ),
    margin:  const EdgeInsets.symmetric(
      vertical: 10.0
    ),
    child: Row(
      children: [
        buildKeyIcon(radius: 30.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    "Limited access",
                    style: StuartTextStyles.w50016,
                  ),
                ),
                Text(
                  "This station is in a private parking."
                      " Please make sure you have entrance permission",
                  style: StuartTextStyles.w40014,
                )
              ],
            ),
          ),
        )
      ],
    ),
  );

}

