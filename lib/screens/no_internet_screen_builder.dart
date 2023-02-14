import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_state.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';


class NoInternetScreenBuilder extends StatefulWidget {

  Widget child;

  NoInternetScreenBuilder({required this.child});

  @override
  _NoInternetScreenBuilderState createState() => _NoInternetScreenBuilderState();
}

class _NoInternetScreenBuilderState extends State<NoInternetScreenBuilder> {

  @override
  void initState() {
    // TODO: implement initState

    //BlocProvider.of<InternetBloc>(context).checkInternet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      child: widget.child,
      listener: (context, internetState){
        if(internetState is NoInternetState){
          Navigator.pushNamed(context, RouteNames.noInternetScreen);
        }
      }
    );
  }
}

