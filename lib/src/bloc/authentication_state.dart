import 'package:equatable/equatable.dart';

import '../ap_interface.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationNotAuthenticated extends AuthenticationState {
}

class AuthenticationAuthenticated extends AuthenticationState {
  final Token token;
  AuthenticationAuthenticated(this.token);
}

class AuthenticationError extends AuthenticationState {
  final String error;
  AuthenticationError(this.error);
}
