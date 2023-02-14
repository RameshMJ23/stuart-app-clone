import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stuartappclone/data/model/connection_info.dart';
import 'package:collection/collection.dart';
import '../constants/StuartTextStyles.dart';
import '../constants/constants.dart';


class BuildEvInfoWidget extends StatelessWidget {

  ConnectionInfo connectionInfo;

  Function(bool) onExpanded;

  BuildEvInfoWidget({
    required this.connectionInfo,
    required this.onExpanded
  });

  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {

    _expandableController.addListener(() {
      onExpanded(_expandableController.value);
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: connectionInfo.available
          ? getGreenColor
          : getRedColor,
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 15.0
      ),
      child: ExpandablePanel(
        controller: _expandableController,
        collapsed: const SizedBox.shrink(),
        header: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0
                  ),
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: Image.asset(
                      "assets/type 2 charger logo white.png"
                    ),
                  ),
                ),
                Text(
                  "22.0kW",
                  style: StuartTextStyles.w60018.copyWith(
                    color: Colors.white
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0
                  ),
                  child: Text(
                    connectionInfo.available
                    ? "Available" : "Offline",
                    style: StuartTextStyles.w60018.copyWith(
                      color: Colors.white
                    ),
                  )
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _expandableController,
                  builder: (context, isOpen, child){
                    return SizedBox(
                      height: 12.0,
                      width: 12.0,
                      child: Image.asset(
                        isOpen
                          ? "assets/expandable_arrow_open_logo.png"
                          : "assets/expandable_arrow_close_logo.png"
                      ),
                    );
                  }
                )
              ],
            )
          ],
        ),
        expanded: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: connectionInfo.infoName.reversed.mapIndexed((index, infoName){
              return (infoName != "available")
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      infoName,
                      style: StuartTextStyles.w40014.copyWith(color: Colors.white),
                    ),
                    (infoName == "Connector ID" || infoName == "Connector name")
                    ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Text(
                        connectionInfo.infoMap[infoName].toString(),
                        style: StuartTextStyles.w40014.copyWith(color: Colors.white),
                      ),
                    )
                    : Text(
                      connectionInfo.infoMap[infoName].toString(),
                      style: StuartTextStyles.w40014.copyWith(color: Colors.white)
                    )
                  ],
                ),
              )
              : const SizedBox.shrink();
            }).toList(),
          ),
        ),
        theme: const ExpandableThemeData(
          hasIcon: false,
        ),
      ),
    );
  }
}
