

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum BitMapDescriptorEnum{
  greenWithKey, greenWithoutKey, redWithKey, redWithoutKey
}

class BitMapDescriptorModel{

  BitMapDescriptorEnum bitMapEnum;

  BitmapDescriptor image;

  BitMapDescriptorModel({
    required this.bitMapEnum,
    required this.image
  });

}