
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';

class FilterBloc extends Cubit<FilterState>{

  FilterBloc():super(FilterState());

  changeFilter(FilterState filterState){
    emit(filterState);
  }
}