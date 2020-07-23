import 'package:equatable/equatable.dart';

import '../ap_interface.dart';
import '../authorization.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}
class LoginButtonPressed extends AuthenticationEvent {
  final User user;
  LoginButtonPressed(this.user);
}

class UserLoggedIn extends AuthenticationEvent {
  final Token token;
  UserLoggedIn(this.token);
}

class UserLoggedError extends AuthenticationEvent {}

class UserLoggedOut extends AuthenticationEvent {}
