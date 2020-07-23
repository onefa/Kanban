import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ap_interface.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc():super(AuthenticationNotAuthenticated());
  APInterface apInterface = APInterface();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {

    if (event is LoginButtonPressed) {
      print('Login button pressed');
      Token token = await apInterface.getToken(event.user);
      if (token.result == 'ok') {
        yield AuthenticationAuthenticated(token);
      } else {
        yield AuthenticationError(token.token.toString());
      }
    }


//    if (event is UserLoggedIn) {
//      yield AuthenticationAuthenticated(token);
//    }

    if (event is UserLoggedOut) {
      yield AuthenticationNotAuthenticated();
    }
  }
}





