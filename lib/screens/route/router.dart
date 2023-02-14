import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/fav_location_bloc.dart';
import 'package:stuartappclone/bloc/location_bloc/location_bloc.dart';
import 'package:stuartappclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:stuartappclone/screens/auth_screen/auth_screen.dart';
import 'package:stuartappclone/screens/auth_screen/auth_wrapper.dart';
import 'package:stuartappclone/screens/auth_screen/sign_up_screen.dart';
import 'package:stuartappclone/screens/charger_point_screen.dart';
import 'package:stuartappclone/screens/filter_screen.dart';
import 'package:stuartappclone/screens/home_screen.dart';
import 'package:stuartappclone/screens/no_internet_screen.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/profile_screens/add_card_screen.dart';
import 'package:stuartappclone/screens/profile_screens/card_detail_screen.dart';
import 'package:stuartappclone/screens/profile_screens/charging_history.dart';
import 'package:stuartappclone/screens/profile_screens/edit_profile_screen.dart';
import 'package:stuartappclone/screens/profile_screens/payment_method_screen.dart';
import 'package:stuartappclone/screens/profile_screens/profile_screen.dart';
import 'package:stuartappclone/screens/profile_screens/report_screen.dart';
import 'package:stuartappclone/screens/profile_screens/rfid_card.dart';
import 'package:stuartappclone/screens/profile_screens/update_rfid_screen.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';
import 'package:stuartappclone/screens/web_view_screen.dart';

class AppRouter{

  final AuthBloc _authBloc = AuthBloc();

  final LocationBloc _locationBloc = LocationBloc();

  final FilterBloc _filterBloc = FilterBloc();

  final UserInfoBloc _userInfoBloc = UserInfoBloc();

  final FavLocationBloc _favLocationBloc = FavLocationBloc();

  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RouteNames.authScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: RouteNames.authScreen
          ),
          builder: (_) => AuthScreen()
        );
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen()
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _locationBloc,
              ),
              BlocProvider.value(
                value: _filterBloc,
              ),
              BlocProvider.value(
                value: _userInfoBloc,
              ),
              BlocProvider.value(
                value: _favLocationBloc,
              )
            ],
            child: HomeScreen(),
          )
        );
      case RouteNames.authWrapperScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => _authBloc,
            child: AuthWrapper(),
            lazy: false,
          )
        );
      case RouteNames.filterScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _filterBloc
              ),
              BlocProvider.value(
                value: _locationBloc
              )
            ],
            child: FilterScreen(
              initType1Val: (routeSettings.arguments as Map)["initType1Val"],
              initType2Val: (routeSettings.arguments as Map)["initType2Val"],
              initPublicParkingVal: (routeSettings.arguments as Map)[
                "initPublicParkingVal"
              ],
              initAvailConnectorsVal: (routeSettings.arguments as Map)[
                "initAvailConnectorsVal"
              ],
              initLowestPowerRange: (routeSettings.arguments as Map)[
                "initLowestPowerRange"
              ],
              initHighestPowerRange: (routeSettings.arguments as Map)[
                "initHighestPowerRange"
              ],
            ),
          )
        );
      case RouteNames.editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _userInfoBloc
              ),
              BlocProvider.value(
                value: _authBloc
              )
            ],
            child: EditProfileScreen(
              initialName: (routeSettings.arguments as Map)["initialName"],
              initialEmail: (routeSettings.arguments as Map)["initialEmail"],
              userImageUrl: (routeSettings.arguments as Map)["userImageUrl"],
            )
          )
        );
      case RouteNames.paymentMethodScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _userInfoBloc,
            child: NoInternetScreenBuilder(
              child: PaymentMethodScreen(),
            )
          )
        );
      case RouteNames.chargingHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => NoInternetScreenBuilder(
              child: ChargingHistoryScreen()
          )
        );
      case RouteNames.rfidCardScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _userInfoBloc,
            child: RFIDCardScreen(),
          )
        );
      case RouteNames.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _userInfoBloc,
            child: ProfileScreen()
          )
        );
      case RouteNames.updateRfidScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: UpdateRFIDScreen(),
          )
        );
      case RouteNames.noInternetScreen:
        return MaterialPageRoute(
          builder: (_) => NoInternetScreen()
        );
      case RouteNames.addCardScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _userInfoBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              )
            ],
            child: AddCardScreen()
          )
        );
      case RouteNames.webViewScreen:
        return MaterialPageRoute(
          builder: (_) => WebViewScreen(
            url: (routeSettings.arguments as Map)["url"]
          )
        );
      case RouteNames.reportScreen:
        return MaterialPageRoute(
          builder: (_) => ReportScreen()
        );
      case RouteNames.cardDetailScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc
              ),
              BlocProvider.value(
                value: _userInfoBloc
              )
            ],
            child: CardDetailScreen(
              cardList: (routeSettings.arguments as Map)["cardList"],
              index: (routeSettings.arguments as Map)["index"]
            )
          )
        );
      case RouteNames.chargerPointScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _locationBloc
              ),
              BlocProvider.value(
                value: _authBloc
              ),
              BlocProvider.value(
                value: _userInfoBloc
              )
            ],
            child: ChargerPointScreen(
              title: (routeSettings.arguments as Map)["title"],
              distance: (routeSettings.arguments as Map)["distance"],
              address: (routeSettings.arguments as Map)["address"],
              isPublic: (routeSettings.arguments as Map)["isPublic"],
              chargersList: (routeSettings.arguments as Map)["chargersList"],
              position: (routeSettings.arguments as Map)["position"],
              icon: (routeSettings.arguments as Map)["icon"],
              chargerId: (routeSettings.arguments as Map)["chargerId"],
            )
          )
        );
    }
  }

}