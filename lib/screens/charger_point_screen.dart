import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:stuartappclone/data/model/card_detail_model.dart';
import 'package:stuartappclone/data/model/connection_info.dart';
import 'package:stuartappclone/data/services/user_service.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:stuartappclone/screens/widgets/build_icon_button.dart';
import 'package:stuartappclone/screens/widgets/detail_scroll_charger_widget.dart';
import 'package:stuartappclone/screens/widgets/scroll_charger_sheet_wiget.dart';


class ChargerPointScreen extends StatefulWidget {


  String title;

  String distance;

  String address;

  bool isPublic;

  List<ConnectionInfo> chargersList;

  LatLng position;

  BitmapDescriptor icon;

  String chargerId;

  ChargerPointScreen({
    required this.title,
    required this.distance,
    required this.address,
    required this.isPublic,
    required this.chargersList,
    required this.position,
    required this.icon,
    required this.chargerId
  });

  @override
  _ChargerPointScreenState createState() => _ChargerPointScreenState();
}

class _ChargerPointScreenState extends State<ChargerPointScreen> {

  late GoogleMapController mapController;

  late ValueNotifier<bool> _showPaymentOption;

  @override
  void initState() {
    // TODO: implement initState

    _showPaymentOption = ValueNotifier<bool>(false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.505,
                child: Stack(
                  children: [
                    GoogleMap(
                      key: const Key("Detailed Map"),
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: false,
                      mapToolbarEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.position.latitude,
                              widget.position.longitude
                          ),
                          zoom: 15.0
                      ),
                      onMapCreated: (controller){
                        mapController = controller;
                      },
                      markers: {
                        Marker(
                            markerId: const MarkerId(
                                "1234"
                            ),
                            icon: widget.icon,
                            position: widget.position
                        )
                      },
                    ),
                    BlocBuilder<UserInfoBloc, UserInfoState>(
                      builder: (context, userInfoState){
                        if(userInfoState is FetchedUserInfoState){

                          bool alreadyFav = userInfoState.userModel.favourites
                              .contains(widget.chargerId);

                          return Positioned(
                            top: 20.0,
                            right: 10.0,
                            child: BuildIconButton(
                              icon: alreadyFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              onPressed: () async{
                                BlocProvider.of<UserInfoBloc>(
                                    context
                                ).favouriteEvPoint(
                                    favouriteList: userInfoState.userModel
                                        .favourites,
                                    chargerId: widget.chargerId,
                                    alreadyFav: alreadyFav,
                                    uid: (BlocProvider.of<AuthBloc>(context).state
                                    as UserState).user.uid
                                );
                              },
                              buttonColor: Colors.white,
                              iconColor: Colors.black87,
                            ),
                          );
                        }else{
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    Positioned(
                      top: 20.0,
                      left: 10.0,
                      child: BuildIconButton(
                        icon: Icons.arrow_back,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        buttonColor: Colors.white,
                        iconColor: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              DetailScrollChargerWidget(
                title: widget.title, distance: widget.distance,
                address: widget.address,
                isPublic: widget.isPublic,
                chargersList: widget.chargersList,
                latitude: widget.position.latitude,
                longitude: widget.position.longitude,
                onPanelExpanded: (isPanelOpen, isChargerAvail){
                  (isPanelOpen && isChargerAvail)
                      ? _showPaymentOption.value = true
                      : _showPaymentOption.value = false;
                },
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _showPaymentOption,
                  builder: (context, isOpen, child){
                    return isOpen
                        ? _paymentOptionWidget(context) : const SizedBox.shrink();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentOptionWidget(
    BuildContext context
  ) => Positioned(
      bottom: 0.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        padding: const EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 20.0
        ),
        decoration: BoxDecoration(
          color: getVioletColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0)
          ),
        ),
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, userInfoState){

            final fetchedUserInfo = (userInfoState is FetchedUserInfoState);

            final isCardAdded = fetchedUserInfo &&
                      userInfoState.userModel.cards.isNotEmpty;

            CardDetailModel? defaultCard = isCardAdded
              ? userInfoState.userModel.cards.where(
                    (cardDetail) => cardDetail.defaultCard).first
              : null;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        defaultCard != null
                        ? defaultCard.cardNumber.startsWith("4")
                            ? buildVisaCard()
                            : buildMasterCard()
                        : const Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0
                          ),
                          child: Text(
                            defaultCard != null
                              ? getCardNumToShow(defaultCard)
                              : "No payment card",
                            style: StuartTextStyles.w60016.copyWith(
                              color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    buildTextButton(
                        buttonName: defaultCard != null
                          ? "Change"
                          : "Add card",
                        textColor: Colors.white,
                        onTap: (){
                          defaultCard != null
                            ?  Navigator.pushNamed(
                              context, RouteNames.paymentMethodScreen)
                            : Navigator.pushNamed(
                                context, RouteNames.addCardScreen);
                        }
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width *0.42,
                        child: BuildButton.transparent(
                          buttonName: "Reserve",
                          onPressed: (){

                          },
                          showBorder: true,
                          contentColor: Colors.white,
                          borderColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width *0.42,
                        child: BuildButton(
                          buttonName: "Start Charging",
                          contentColor: getVioletColor,
                          onPressed: (){

                          },
                          buttonColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      )
  );
}
