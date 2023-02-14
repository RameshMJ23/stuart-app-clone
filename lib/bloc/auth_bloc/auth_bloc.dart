
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:stuartappclone/bloc/auth_bloc/auth_state.dart';
import 'package:stuartappclone/data/services/auth_services.dart';

class AuthBloc extends Cubit<AuthState>{

  AuthBloc():super(LoadingAuthState()){
    AuthService().authStream.listen((event) {
      if(event != null && event.uid != null){
        emit(UserState(user: event));
      }else{
        emit(NoUserState());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();

    return Future.value();
  }
}