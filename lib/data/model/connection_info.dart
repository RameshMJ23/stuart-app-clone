
List<ConnectionInfo> mapToConnectionInfoList(
  List connectionList
) => connectionList.map((data){
  return ConnectionInfo.mapToModel(data as Map<String, dynamic>);
}).toList();

class ConnectionInfo{

  String Connector_ID;

  String Connector_type;

  String Price_per_kWh;

  String Price_per_minute;

  String Start_Price;

  bool available;

  double power;

  List infoName;

  Map infoMap;

  ConnectionInfo({
    required this.Connector_ID,
    required this.Connector_type,
    required this.Price_per_kWh,
    required this.Price_per_minute,
    required this.Start_Price,
    required this.available,
    required this.infoName,
    required this.infoMap,
    this.power = 22.0,
  });

  factory ConnectionInfo.mapToModel(
    Map<String, dynamic> infoMap
  ) => ConnectionInfo(
    Connector_ID: infoMap["Connector ID"] ?? infoMap["Connector name"],
    Connector_type: infoMap["Connector type"],
    Price_per_kWh: infoMap["Price per kWh"],
    Price_per_minute: infoMap["Price per minute"],
    Start_Price: infoMap["Start Price"],
    available: infoMap["available"],
    power: 22.0,
    infoName: infoMap.keys.toList(),
    infoMap: infoMap
  );

}