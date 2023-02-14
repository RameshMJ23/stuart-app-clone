

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_bloc.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/widgets/custom_switch_tile.dart';

class FilterScreen extends StatefulWidget {

  bool initType1Val;
  bool initType2Val;
  bool initAvailConnectorsVal;
  bool initPublicParkingVal;
  String initLowestPowerRange;
  String initHighestPowerRange;

  FilterScreen({
    required this.initType1Val,
    required this.initType2Val,
    required this.initAvailConnectorsVal,
    required this.initPublicParkingVal,
    required this.initLowestPowerRange,
    required this.initHighestPowerRange,
  });

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  late final ValueNotifier<RangeValues> _rangeNotifier;

  late final ValueNotifier<bool> _type1Notif;

  late final ValueNotifier<bool> _type2Notif;

  late final ValueNotifier<bool> _availConnectorsNotif;

  late final ValueNotifier<bool> _publicParkingNotif;

  @override
  void initState() {
    // TODO: implement initState

    _rangeNotifier = ValueNotifier(
      RangeValues(
        _getFilterStateRangeVal(widget.initLowestPowerRange),
        _getFilterStateRangeVal(widget.initHighestPowerRange)
      )
    );
    _type1Notif = ValueNotifier<bool>(widget.initType1Val);
    _type2Notif = ValueNotifier<bool>(widget.initType2Val);
    _availConnectorsNotif = ValueNotifier<bool>(widget.initAvailConnectorsVal);
    _publicParkingNotif = ValueNotifier<bool>(widget.initPublicParkingVal);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return NoInternetScreenBuilder(
      child: WillPopScope(
          child: Scaffold(
            backgroundColor: getPeachColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: getPeachColor,
              title: Text(
                "Filter",
                style: StuartTextStyles.w60018,
              ),
              centerTitle: true,
              actions: [
                Align(
                  alignment: Alignment.centerRight,
                  child: buildTextButton(
                      buttonName: "Done",
                      onTap: (){

                        final updatedFilterState = FilterState(
                            type1: _type1Notif.value,
                            type2: _type2Notif.value,
                            availConnectors: _availConnectorsNotif.value,
                            publicConnectors: _publicParkingNotif.value,
                            lowestPowerRange:  _getRealRangeVal(_rangeNotifier.value.start, true),
                            highestPowerRange: _getRealRangeVal(_rangeNotifier.value.end, true)
                        );

                        BlocProvider.of<FilterBloc>(context).changeFilter(
                            updatedFilterState
                        );

                        BlocProvider.of<LocationBloc>(context).filterLocation(
                            updatedFilterState
                        );

                        Navigator.pop(context);

                      }
                  ),
                )
              ],
              leading: getAppBarLeading(context: context),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 20.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSwitchTile(
                    initialVal: widget.initType1Val,
                    switchKey: const Key("Type_1_switch_key"),
                    title: "Type 1",
                    onChangeFunc: (val){
                      _type1Notif.value = val;
                    },
                    imageUrl: "assets/type 1 charger logo.png",
                  ),
                  CustomSwitchTile(
                    initialVal: widget.initType2Val,
                    switchKey: const Key("Type_2_switch_key"),
                    title: "Type 2",
                    onChangeFunc: (val){
                      _type2Notif.value = val;
                    },
                    imageUrl: "assets/type 2 charger logo.png",
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(
                        top: 15.0, left: 10.0
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _rangeNotifier,
                      builder: (context, RangeValues val, child){
                        return Text(
                          "${_getRealRangeVal(val.start, false)}"
                              " - ${_getRealRangeVal(val.end, false)}",
                          style: StuartTextStyles.w60016,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder(
                        valueListenable: _rangeNotifier,
                        builder: (context, RangeValues rangeVal, child){
                          return SliderTheme(
                              data: SliderThemeData(
                                activeTrackColor: getVioletColor,
                                activeTickMarkColor: Colors.white,
                                thumbColor: getVioletColor,
                                inactiveTrackColor: getVioletColor.withOpacity(0.3),
                                inactiveTickMarkColor: getVioletColor,
                              ),
                              child: RangeSlider(
                                values: rangeVal,
                                onChanged: (val){
                                  if(val.start.round() != 175
                                      && val.end.round() != 0){
                                    _rangeNotifier.value = val;
                                  }
                                },
                                divisions: 6,
                                min: 0,
                                max: 175.0,
                                labels: RangeLabels(
                                    _getRealRangeVal(rangeVal.start, false),
                                    _getRealRangeVal(rangeVal.end, false)
                                ),
                                semanticFormatterCallback: (val){
                                  return val.toString();
                                },
                              )
                          );
                        },
                      ),
                    ),
                  ),
                  CustomSwitchTile(
                    initialVal: widget.initAvailConnectorsVal,
                    switchKey: const Key("avail_connectors_switch_key"),
                    title: "Only available connectors",
                    onChangeFunc: (val){
                      _availConnectorsNotif.value = val;
                    },
                  ),
                  CustomSwitchTile(
                    initialVal: widget.initPublicParkingVal,
                    switchKey: const Key("public_parking_switch_key"),
                    title: "Only in public parking",
                    onChangeFunc: (val){
                      _publicParkingNotif.value = val;
                    },
                  )
                ],
              ),
            ),
          ),
          onWillPop: () async{
            return Future.value(true);
          }
      ),
    );
  }

  _getRealRangeVal(double sliderValue, bool getWithoutKW){
    switch(sliderValue.round().toStringAsFixed(1)){
      case "29.0":
        return getWithoutKW
          ? "11.0" : "11.0kW";
      case "58.0":
        return getWithoutKW
          ? "22.0" :"22.0kW";
      case "88.0":
        return getWithoutKW
          ? "30.0" :"30.0kW";
      case "117.0":
        return getWithoutKW
          ? "50.0" :"50.0kW";
      case "146.0":
        return getWithoutKW
          ? "100.0" :"100kW";
      case "175.0":
        return getWithoutKW
          ? "175.0" : "175+kW";
      default:
        return "0.0";
    }
  }

  double _getFilterStateRangeVal(String sliderValue){
    switch(sliderValue){
      case "11.0":
        return 29.0;
      case "22.0" :
        return 58.0;
      case "30.0":
        return 88.0;
      case "50.0":
        return 117.0;
      case "100.0":
        return 146.0;
      case "175.0":
        return 175.0;
      default:
        return 0.0;
    }
  }
}

