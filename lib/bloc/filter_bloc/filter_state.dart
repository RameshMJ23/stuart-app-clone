

import 'package:equatable/equatable.dart';

class FilterState extends Equatable{

  bool type1;

  bool type2;

  bool availConnectors;

  bool publicConnectors;

  String lowestPowerRange;

  String highestPowerRange;

  FilterState({
    this.type1 = true,
    this.type2 = true,
    this.availConnectors = false,
    this.publicConnectors = false,
    this.lowestPowerRange = "0.0",
    this.highestPowerRange = "175.0"
  });

  @override
  // TODO: implement props
  List<Object?> get props => [type1,type2, availConnectors, publicConnectors,
    lowestPowerRange, highestPowerRange
  ];

}