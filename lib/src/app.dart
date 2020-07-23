import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authorization.dart';
import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_state.dart';
import 'kanban.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>.value(
      value: authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        builder: (context, state) {
          if (state is AuthenticationNotAuthenticated) {
            return AuthorizationPage();
          }
          if (state is AuthenticationAuthenticated) {
            return Kanban();
          }
          if (state is AuthenticationError) {
            return AuthorizationError();
          }
          return AuthorizationPage();
        },
      ),
    );

  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

}
