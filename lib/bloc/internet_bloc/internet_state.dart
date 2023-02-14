import 'package:equatable/equatable.dart';

class InternetState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RefreshingInternetState extends InternetState{

}

class NoInternetState extends InternetState{

}

class YesInternetState extends InternetState{

}